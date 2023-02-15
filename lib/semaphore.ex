defmodule Semaphore do
  def new(count \\ 1) do
    spawn(Semaphore, :loop, [count, []])
  end

  def acquire(pid) do
    ref = make_ref()
    send(pid, {:acquire, self(), ref})
    receive do
      {:ok, ^ref} -> :ok
    end
  end

  def release(pid) do
    send(pid, :release)
    :ok
  end

  def loop(count, queue) do
    receive do
      {:acquire, sender, ref} ->
        case count do
          0 ->
            loop(count, queue ++ [{sender, ref}])

          count ->
            send(sender, {:ok, ref})
            loop(count-1, queue)
        end

      :release ->
        case count do
          0 ->
            case queue do
              [] ->
                loop(count+1, queue)

              [{sender, ref} | queue] ->
                send(sender, {:ok, ref})
                loop(count, queue)
            end
            loop(count, queue)

          count ->
            loop(count+1, queue)
        end
    end
  end
end
