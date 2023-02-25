defmodule StarWarsApi do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: StarWarsApi.Router, options: [port: 8080]},
      {StarWarsApi.InMemoryDb, []}
    ]
    opts = [strategy: :one_for_one, name: StarWarsApi.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end

defmodule StarWarsApi.Router do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug :match
  plug :dispatch

  get "/movies" do
    movies = StarWarsApi.InMemoryDb.get_all_movies()
    send_resp(conn, 200, Jason.encode!(movies))
  end

  get "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = StarWarsApi.InMemoryDb.get_movie(id)
    send_resp(conn, 200, Jason.encode!(movie))
  end

  post "/movies" do
    movie = conn.body_params
    new_movie = StarWarsApi.InMemoryDb.create_movie(movie)
    send_resp(conn, 201, Jason.encode!(new_movie))
  end

  put "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.InMemoryDb.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  patch "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.InMemoryDb.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  delete "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    StarWarsApi.InMemoryDb.delete_movie(id)
    send_resp(conn, 204, "")
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end

defmodule StarWarsApi.InMemoryDb do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    :ets.new(:movies_table, [:set, :public, :named_table])
    :ok = load_movies_into_table(:movies_table)
    {:ok, :movies_table}
  end

  defp load_movies_into_table(table) do
    movies = [
      %{
        id: 1,
        title: "Star Wars: Episode IV - A New Hope",
        director: "George Lucas",
        release_year: 1977
      },
      %{
        id: 2,
        title: "Star Wars: Episode V - The Empire Strikes Back",
        director: "Irvin Kershner",
        release_year: 1980
      },
      %{
        id: 3,
        title: "Star Wars: Episode VI - Return of the Jedi",
        director: "Richard Marquand",
        release_year: 1983
      },
      %{
        id: 4,
        title: "Star Wars: Episode I - The Phantom Menace",
        director: "George Lucas",
        release_year: 1999
      },
      %{
        id: 5,
        title: "Star Wars: Episode II - Attack of the Clones",
        director: "George Lucas",
        release_year: 2002
      },
      %{
        id: 6,
        title: "Star Wars: Episode III - Revenge of the Sith",
        director: "George Lucas",
        release_year: 2005
      },
      %{
        id: 7,
        title: "Star Wars: Episode VII - The Force Awakens",
        director: "J.J. Abrams",
        release_year: 2015
      },
      %{
        id: 8,
        title: "Star Wars: Episode VIII - The Last Jedi",
        director: "Rian Johnson",
        release_year: 2017
      },
      %{
        id: 9,
        title: "Star Wars: Episode IX - The Rise of Skywalker",
        director: "J.J. Abrams",
        release_year: 2019
      },
      %{
        id: 10,
        title: "Star Wars: Episode III - Revenge of the Sith",
        director: "George Lucas",
        release_year: 2005
      }
    ]

    Enum.each(movies, fn movie ->
      :ets.insert(table, {movie[:id], movie})
    end)
  end

  def handle_call(:get_all_movies, _from, table) do
    movies = Enum.map(:ets.tab2list(table), fn {key, movie} -> Map.put(movie, :id, key) end)
    {:reply, movies, table}
  end

  def handle_call({:get_movie, id}, _from, table) do
    movies = :ets.lookup(table, id)
    if length(movies) == 0 do
      {:reply, nil, table}
    else
      {key, movie} = List.first(movies)
      {:reply, %{movie | id: key}, table}
    end
  end

  def handle_call({:create_movie, movie}, _from, table) do
    id = :ets.info(table, :size) + 1
    Map.put(movie, :id, id)
    :ets.insert(table, {id, movie})
    {:reply, :ok, table}
  end

  def handle_call({:update_movie, id, movie}, _from, table) do
    :ets.insert(table, {id, movie})
    {:reply, :ok, table}
  end

  def handle_call({:delete_movie, id}, _from, table) do
    :ets.delete(table, id)
    {:reply, :ok, table}
  end

  def get_all_movies do
    GenServer.call(__MODULE__, :get_all_movies)
  end

  def get_movie(id) do
    GenServer.call(__MODULE__, {:get_movie, id})
  end

  def create_movie(movie) do
    GenServer.call(__MODULE__, {:create_movie, movie})
  end

  def update_movie(id, movie) do
    GenServer.call(__MODULE__, {:update_movie, id, movie})
  end

  def delete_movie(id) do
    GenServer.call(__MODULE__, {:delete_movie, id})
  end
end
