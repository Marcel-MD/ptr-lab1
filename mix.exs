defmodule Lab1.MixProject do
  use Mix.Project

  def project do
    [
      app: :lab1,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :floki, :jason, :plug_cowboy],
      mod: {StarWarsApi, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:floki, "~> 0.34.0"},
      {:jason, "~> 1.3"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
