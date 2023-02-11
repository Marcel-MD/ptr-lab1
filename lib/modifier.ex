defmodule Modifier do
  def loop do
    receive do
      message when is_integer(message) ->
        IO.puts("Received: #{message}")

      message when is_bitstring(message) ->
        IO.puts("Received: #{message}")

      _ ->
        IO.puts("Received: I don't know how to HANDLE this!")
    end

    loop()
  end
end
