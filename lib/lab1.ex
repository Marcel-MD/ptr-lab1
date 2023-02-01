defmodule Lab1 do
  def get_hello do
    "Hello, PTR!"
  end

  def say_hello do
    get_hello |> IO.puts()
  end
end
