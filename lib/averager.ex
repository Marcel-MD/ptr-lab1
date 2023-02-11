defmodule Averager do
  def loop(sum, count) do
    receive do
      value when is_integer(value) ->
        sum = sum+value
        count = count+1
        IO.puts("Current average is: #{sum/count}")
        loop(sum, count)
    end
  end
end
