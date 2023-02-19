defmodule Worker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def call(pid, msg) do
    GenServer.call(pid, msg)
  end

  def kill(pid) do
    GenServer.cast(pid, :kill)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, msg, state}
  end

  def handle_cast(:kill, state) do
    {:stop, :killed, state}
  end
end

defmodule Super do
  use Supervisor

  def start_link(num_workers) do
    Supervisor.start_link(__MODULE__, num_workers: num_workers, name: __MODULE__)
    |> elem(1)
  end

  def init(args) do
    children = Enum.map(1..args[:num_workers], fn i ->
      %{
        id: i,
        start: {Worker, :start_link, []}
      }
    end)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker_pid(pid, id) do
    Supervisor.which_children(pid)
    |> Enum.find(fn {i, _, _, _} -> i == id end)
    |> elem(1)
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end
end
