defmodule Lab1Test do
  use ExUnit.Case
  doctest Lab1

  test "hello PTR" do
    assert Lab1.hello() == :ok
  end
end
