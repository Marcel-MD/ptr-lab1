defmodule Lab1Test do
  use ExUnit.Case
  doctest Lab1

  test "get hello" do
    assert Lab1.get_hello() == "Hello, PTR!"
  end

  test "say hello" do
    assert Lab1.say_hello() == :ok
  end
end
