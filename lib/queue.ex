defmodule Queue do

  def new_queue do
    spawn(Queue, :loop, [[]])
  end

  def queue(pid, value) do
    send(pid, {:queue, value})
    :ok
  end

  def dequeue(pid) do
    ref = make_ref()
    send(pid, {:dequeue, self(), ref})
    receive do
      {:ok, ^ref, value} -> value
    end
  end

  def loop(queue) do
    receive do
      {:queue, value} ->
        loop([value | queue])

      {:dequeue, sender, ref} ->
        case queue do
          [] ->
            send(sender, {:error, ref, nil})

          queue ->
            send(sender, {:ok, ref, List.last(queue)})
            loop(List.delete_at(queue, -1))
        end
    end
  end
end
