defmodule Scheduler do
  def create_scheduler do
    spawn(fn -> scheduler_loop() end)
  end

  def schedule(pid, task) do
    send(pid, {:schedule, task})
  end

  defp scheduler_loop do
    Process.flag(:trap_exit, true)
    loop()
  end

  defp loop do
    receive do
      {:schedule, task} ->
        create_worker(task)

      {:EXIT, _pid, :normal} ->
        IO.puts("Task succesful : Miau")

      {:EXIT, _pid, task} ->
        IO.puts("Task fail")
        create_worker(task)
    end
    loop()
  end

  defp create_worker(task) do
    spawn_link(fn -> worker_loop(task) end)
  end

  defp worker_loop(task) do
    if :rand.uniform() < 0.5 do
      exit(:normal)
    else
      exit(task)
    end
  end

end
