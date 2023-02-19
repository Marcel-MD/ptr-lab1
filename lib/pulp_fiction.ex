defmodule PulpFiction do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    |> elem(1)
  end

  def init(_) do
    children = [
      %{
        id: :killer_worker,
        start: {Killer, :start_link, []}
      },
      %{
        id: :guy_worker,
        start: {Guy, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def play() do
    Killer.ask()
    play()
  end

  def count() do
    Supervisor.count_children(__MODULE__)
  end
end

defmodule Killer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def ask() do
    GenServer.call(__MODULE__, :ask)
  end

  def init(_) do
    state = %{
      questions: [
        "What does Marcellus look like?",
        "What country you from?!",
        "What ain't no country I've ever heard of! They speak English in What?",
        "English motherfucker do you speak it!?",
        "Describe what Marcellus Wallace looks like.",
        "Dose he look like a bitch?",
      ],
      warning: "Say what again. SAY WHAT again! And I dare you, I double dare you motherfucker! Say what one more time.",
      what_count: 0
    }
    {:ok, state}
  end

  def handle_call(:ask, _from, state) do
    Process.sleep(1500)

    question = Enum.random(state[:questions])
    IO.puts("Killer: #{question}")

    answer = Guy.answer()

    if (answer == "What?") do
      state = %{state | what_count: state[:what_count] + 1}

      case state[:what_count] do
        5 ->
          Process.sleep(500)
          IO.puts("BANG!")
          Guy.kill()
        4 ->
          Process.sleep(500)
          IO.puts("Killer: #{state[:warning]}")
        _ -> :ok
      end

      {:reply, question, state}
    else
      {:reply, question, state}
    end
  end
end

defmodule Guy do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def answer() do
    GenServer.call(__MODULE__, :answer)
  end

  def kill() do
    GenServer.cast(__MODULE__, :kill)
  end

  def init(_) do
    state = %{
      answers: [
        "Yes",
        "He's black",
        "He's bald",
      ]
    }
    {:ok, state}
  end

  def handle_call(:answer, _from, state) do
    Process.sleep(2000)

    if (:rand.uniform() > 0.6) do
      answer = Enum.random(state[:answers])
      IO.puts("Guy: #{answer}")
      {:reply, answer, state}
    else
      IO.puts("Guy: What?")
      {:reply, "What?" , state}
    end
  end

  def handle_cast(:kill, state) do
    {:stop, :normal, state}
  end
end
