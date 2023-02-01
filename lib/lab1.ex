alias :math, as: Math

defmodule Lab1 do
  def get_hello do
    "Hello, PTR!"
  end

  def say_hello do
    get_hello |> IO.puts()
  end

  def is_prime?(n) when n < 2 do
    false
  end

  def is_prime?(n) do
    nums = 2..(n - 1)
    Enum.all?(nums, fn x -> rem(n, x) != 0 end)
  end

  def cylinder_area(r, h) do
    2 * Math.pi() * r * (r + h)
  end

  def reverse_list(list) do
    Enum.reverse(list)
  end

  def unique_sum(list) do
    Enum.uniq(list) |> Enum.sum()
  end

  def extract_random_list(list, n) do
    Enum.take_random(list, n)
  end

  def first_fibonacci(n) when n == 1 do
    [1]
  end

  def first_fibonacci(n) when n == 2 do
    [1, 1]
  end

  def first_fibonacci(n) when n > 2 do
    fib = first_fibonacci(n - 1)
    next_number = Enum.at(fib, n - 2) + Enum.at(fib, n - 3)
    fib ++ [next_number]
  end

  def translate(dictionary, text) do
    Enum.map(text, fn word -> Map.get(dictionary, word, word) end)
  end

  def smallest_number(a, b, c) when a == 0 and b == 0 and c == 0 do
    0
  end

  def smallest_number(a, b, c) do
    [a, b, c]
    |> Enum.sort()
    |> move_zeros()
    |> Enum.join()
    |> String.to_integer()
  end

  defp move_zeros(list) do
    [head | tail] = list

    if head == 0 do
      tail = move_zeros(tail)
      [h | t] = tail
      [h, head | t]
    else
      list
    end
  end

  def rotate_left(list, n) when n == 0 do
    list
  end

  def rotate_left(list, n) when n > 0 do
    [head | tail] = list
    rotate_left(tail ++ [head], n - 1)
  end

  def remove_consecutive_duplicates(list) do
    Enum.reduce(list, [], fn x, acc ->
      if Enum.at(acc, -1) == x do
        acc
      else
        acc ++ [x]
      end
    end)
  end
end
