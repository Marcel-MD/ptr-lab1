alias :math, as: Math

defmodule Lab1 do
  def get_hello do
    "Hello, PTR!"
  end

  def is_prime?(n) when n < 2 do
    false
  end

  def is_prime?(n) when n < 4 do
    true
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

  def list_right_angle_triangles() do
    for a <- 1..20,
        b <- 1..20,
        c <- 1..40,
        a + b > c and a + c > b and b + c > a and a * a + b * b == c * c do
      {a, b, c}
    end
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

  def one_row_words(list) do
    rows = [
      "qwertyuiop",
      "asdfghjkl",
      "zxcvbnm"
    ]

    for row <- rows,
        word <- list,
        Enum.all?(word |> String.downcase() |> String.graphemes(), fn x ->
          String.contains?(row, x)
        end) do
      word
    end
  end

  def encode_caesar(str, shift) do
    str
    |> String.to_charlist()
    |> Enum.map(fn codepoint ->
      if codepoint + shift <= 126 do
        codepoint + shift
      else
        codepoint + shift - 94
      end
    end)
    |> List.to_string()
  end

  def decode_caesar(str, shift) do
    encode_caesar(str, -shift)
  end

  def group_anagrams(strings) do
    strings
    |> Enum.group_by(fn string ->
      string
      |> String.downcase()
      |> String.split("")
      |> Enum.sort()
      |> List.to_string()
    end)
    |> Enum.map(fn {_key, group} -> group end)
    |> Enum.to_list()
  end

  def common_prefix(strings) do
    Enum.reduce(strings, fn string, acc ->
      if String.starts_with?(string, acc) do
        acc
      else
        common_prefix(string, acc)
      end
    end)
  end

  def common_prefix(string1, string2) do
    <<head1, tail1::binary>> = string1
    <<head2, tail2::binary>> = string2

    if head1 == head2 do
      <<head1>> <> common_prefix(tail1, tail2)
    else
      <<>>
    end
  end

  def factorize(n) do
    factorize(n, 2)
  end

  defp factorize(n, _) when n == 1 do
    []
  end

  defp factorize(n, i) do
    if is_prime?(i) && rem(n, i) == 0 do
      [i | factorize(round(n / i), i)]
    else
      factorize(n, i + 1)
    end
  end

  def to_roman(n) do
    to_roman(n, "")
  end

  defp to_roman(n, acc) when n == 0 do
    acc
  end

  defp to_roman(n, acc) when n >= 1000 do
    to_roman(n - 1000, acc <> "M")
  end

  defp to_roman(n, acc) when n >= 900 do
    to_roman(n - 900, acc <> "CM")
  end

  defp to_roman(n, acc) when n >= 500 do
    to_roman(n - 500, acc <> "D")
  end

  defp to_roman(n, acc) when n >= 400 do
    to_roman(n - 400, acc <> "CD")
  end

  defp to_roman(n, acc) when n >= 100 do
    to_roman(n - 100, acc <> "C")
  end

  defp to_roman(n, acc) when n >= 90 do
    to_roman(n - 90, acc <> "XC")
  end

  defp to_roman(n, acc) when n >= 50 do
    to_roman(n - 50, acc <> "L")
  end

  defp to_roman(n, acc) when n >= 40 do
    to_roman(n - 40, acc <> "XL")
  end

  defp to_roman(n, acc) when n >= 10 do
    to_roman(n - 10, acc <> "X")
  end

  defp to_roman(n, acc) when n >= 9 do
    to_roman(n - 9, acc <> "IX")
  end

  defp to_roman(n, acc) when n >= 5 do
    to_roman(n - 5, acc <> "V")
  end

  defp to_roman(n, acc) when n >= 4 do
    to_roman(n - 4, acc <> "IV")
  end

  defp to_roman(n, acc) when n >= 1 do
    to_roman(n - 1, acc <> "I")
  end
end
