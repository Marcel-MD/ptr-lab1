defmodule Semaphore do
  def create_semaphore(count \\ 1) do
    spawn(Semaphore, :loop, [count])
  end

  def acquire(pid) do
    ref = make_ref()
    send(pid, {:acquire, self(), ref})
    receive do
      {:ok, ^ref} -> :ok
      {:error, ^ref} -> :error
    end
  end

  def release(pid) do
    send(pid, :release)
    :ok
  end

  def loop(count) do
    receive do
      {:acquire, sender, ref} ->
        case count do
          0 ->
            send(sender, {:error, ref})
            loop(count)

          count ->
            send(sender, {:ok, ref})
            loop(count-1)
        end

      :release ->
        case count do
          0 ->
            loop(count)

          count ->
            loop(count+1)
        end
    end
  end
end
