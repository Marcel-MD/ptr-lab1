# FAF.PTR16.1 -- Project 0
> **Performed by:** Marcel Vlasenco, group FAF-203
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W2

**Task 1** -- Is a number prime?

```elixir
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
```

`is_prime` function takes a number `n` and checks if it is prime. If `n` is less than 2, it is not prime. If `n` is less than 4, it is prime. Otherwise, it checks if `n` is divisible by any number from 2 to `n - 1`. If it is, it is not prime. Otherwise, it is prime.

**Task 2** -- Calculate the area of a cylinder

```elixir
  def cylinder_area(r, h) do
    2 * Math.pi() * r * (r + h)
  end
```

`cylinder_area` function takes the radius `r` and the height `h` of a cylinder and returns the area of the cylinder.

**Task 3** -- Reverse List

```elixir
  def reverse_list(list) do
    Enum.reverse(list)
  end
```

`reverse_list` function takes a list and returns the reversed list.

**Task 4** -- Unique sum from list

```elixir
  def unique_sum(list) do
    Enum.uniq(list) |> Enum.sum
  end
```

`unique_sum` function takes a list and returns the sum of the unique elements of the list.

**Task 5** -- Extract random list

```elixir
  def extract_random_list(list, n) do
    Enum.take_random(list, n)
  end
```

`extract_random_list` function takes a list and a number `n` and returns a list of `n` random elements from the list.

**Task 6** -- Fibonacci list

```elixir
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
```

`first_fibonacci` function takes a number `n` and returns a list of the first `n` Fibonacci numbers. If `n` is 1, it returns `[1]`. If `n` is 2, it returns `[1, 1]`. Otherwise, it calculates the next Fibonacci number by adding the last two numbers in the list and appends it to the list.

**Task 7** -- Translate text

```elixir
  def translate(dictionary, text) do
    Enum.map(text, fn word -> Map.get(dictionary, word, word) end)
  end
```

`translate` function takes a dictionary and a text and returns the text translated using the dictionary. If a word is not in the dictionary, it is not translated.

**Task 8** -- Smallest number from 3 digits

```elixir
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
```

**Task 9** -- Rotate list to left

```elixir
  def rotate_left(list, n) when n == 0 do
    list
  end

  def rotate_left(list, n) when n > 0 do
    [head | tail] = list
    rotate_left(tail ++ [head], n - 1)
  end
```

`rotate_left` function takes a list and a number `n` and returns the list rotated `n` times to the left. If `n` is 0, it returns the list. Otherwise, it takes the first element of the list and appends it to the end of the list and calls itself with the new list and `n - 1`.

**Task 10** -- List right angle triangles

```elixir
  def list_right_angle_triangles() do
    for a <- 1..20,
        b <- 1..20,
        c <- 1..40,
        a + b > c and a + c > b and b + c > a and a * a + b * b == c * c do
      {a, b, c}
    end
  end
```

`list_right_angle_triangles` function returns a list of all right angle triangles with sides from 1 to 20.

**Task 11** -- Remove consecutive duplicates

```elixir
  def remove_consecutive_duplicates(list) do
    Enum.reduce(list, [], fn x, acc ->
      if Enum.at(acc, -1) == x do
        acc
      else
        acc ++ [x]
      end
    end)
  end
```

`remove_consecutive_duplicates` function takes a list and returns the list with consecutive duplicates removed. It uses `Enum.reduce` to iterate over the list and append the current element to the accumulator if it is not equal to the last element of the accumulator.

**Task 12** -- Words that can be written with one row of the keyboard

```elixir
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
```

`one_row_words` function takes a list of words and returns the words that can be written with one row of the keyboard. It uses `String.graphemes` to split the word into a list of characters. It then checks if all characters are in the same row of the keyboard. If they are, it returns the word.

**Task 13** -- Caesar cipher

```elixir
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
```

`encode_caesar` function takes a string and a number `shift` and returns the string encoded using the Caesar cipher with the given shift. It uses `String.to_charlist` to convert the string to a list of codepoints. It then adds the shift to each codepoint and returns the new string. If the codepoint is greater than 126, it subtracts 94 from it to wrap around the ASCII table. `decode_caesar` is the same as `encode_caesar` but with a negative shift.

**Task 14** -- Group anagrams

```elixir
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
```

`group_anagrams` function takes a list of strings and returns a list of lists of anagrams. It uses `Enum.group_by` to group the strings by their sorted characters. It then uses `Enum.map` to get the groups and `Enum.to_list` to convert the enumerable to a list.

**Task 15** -- Common Prefix

```elixir
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
```

`common_prefix` function takes a list of strings and returns the common prefix of all strings. It uses `Enum.reduce` to iterate over the list and call `common_prefix` with the current string and the accumulator. `common_prefix` takes two strings and returns the common prefix of the two strings. It uses pattern matching to get the first character of each string. If they are equal, it returns the character concatenated with the common prefix of the rest of the strings. Otherwise, it returns an empty string. It uses `String.starts_with?` to check if the current string starts with the accumulator. If it does, it returns the accumulator. Otherwise, it calls `common_prefix` with the current string and the accumulator.

**Task 16** -- Prime factorization

```elixir
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
```

`factorize` function takes a number and returns a list of its prime factors. It uses `factorize` with the number and 2 as arguments. `factorize` takes a number and a number `i` and returns a list of its prime factors. It uses pattern matching to check if the number is 1. If it is, it returns an empty list. Otherwise, it checks if `i` is a prime number and if `n` is divisible by `i`. If it is, it returns `i` concatenated with the result of calling `factorize` with `n` divided by `i` and `i`. Otherwise, it calls `factorize` with `n` and `i` incremented by 1. `is_prime?` function takes a number and returns true if it is a prime number and false otherwise. It uses `Enum.all?` to check if the number is divisible by any number from 2 to the square root of the number.

**Task 17** -- To roman numbers

```elixir
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
```

`to_roman` function takes a number and returns its roman representation. It uses `to_roman` with the number and an empty string as arguments. `to_roman` takes a number and a string `acc` and returns its roman representation. It uses pattern matching to check if the number is 0. If it is, it returns the accumulator. Otherwise, it checks if the number is greater than or equal to 1000. If it is, it calls `to_roman` with the number minus 1000 and the accumulator concatenated with "M". It does the same for the other numbers.

## P0W3

**Task 1** -- Actor that prints messages

```elixir
defmodule Talker do
  def loop do
    receive do
      message ->
        IO.puts(message)
    end

    loop()
  end
end
```

`Talker` receives a message and prints it.

**Task 2** -- Actor that prints modified messages

```elixir
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
```

`Modifier` receives a message and modifies it. It uses pattern matching to check if the message is an integer or a bitstring. If it is, it prints the message. Otherwise, it prints a message saying that it doesn't know how to handle the message.

**Task 3** -- Actor that returns average of numbers

```elixir
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
```

`Averager` receives a number and returns the average of the numbers it has received so far. It uses pattern matching to check if the message is an integer. If it is, it adds the number to the sum and increments the count. It then prints the average and calls `loop` with the new sum and count.

**Task 4** -- Queue actor

```elixir
defmodule Queue do

  def new_queue do
    spawn(Queue, :loop, [[]])
  end

  def queue(pid, value) do
    send(pid, {:queue, value})
    :ok
  end

  def dequeue(pid) do
    ref = make_ref()
    send(pid, {:dequeue, self(), ref})
    receive do
      {:ok, ^ref, value} -> value
    end
  end

  def loop(queue) do
    receive do
      {:queue, value} ->
        loop([value | queue])

      {:dequeue, sender, ref} ->
        case queue do
          [] ->
            send(sender, {:error, ref, nil})

          queue ->
            send(sender, {:ok, ref, List.last(queue)})
            loop(List.delete_at(queue, -1))
        end
    end
  end
end
```

`Queue` is an actor that can queue and dequeue values. It uses pattern matching to check if the message is `{:queue, value}`. If it is, it calls `loop` with the value added to the queue. It does the same for `{:dequeue, sender, ref}`. It checks if the queue is empty. If it is, it sends an error message to the sender. Otherwise, it sends the last value of the queue to the sender and calls `loop` with the last value removed from the queue.

**Task 5** -- Semaphore actor

```elixir
defmodule Semaphore do
  def new(count \\ 1) do
    spawn(Semaphore, :loop, [count, []])
  end

  def acquire(pid) do
    ref = make_ref()
    send(pid, {:acquire, self(), ref})
    receive do
      {:ok, ^ref} -> :ok
    end
  end

  def release(pid) do
    send(pid, :release)
    :ok
  end

  def loop(count, queue) do
    receive do
      {:acquire, sender, ref} ->
        case count do
          0 ->
            loop(count, queue ++ [{sender, ref}])

          count ->
            send(sender, {:ok, ref})
            loop(count-1, queue)
        end

      :release ->
        case count do
          0 ->
            case queue do
              [] ->
                loop(count+1, queue)

              [{sender, ref} | queue] ->
                send(sender, {:ok, ref})
                loop(count, queue)
            end
            loop(count, queue)

          count ->
            loop(count+1, queue)
        end
    end
  end
end
```

`Semaphore` is an actor that can acquire and release a semaphore. It uses pattern matching to check if the message is `{:acquire, sender, ref}`. If it is, it checks if the count is 0. If it is, it adds the sender and ref to the queue. Otherwise, it sends an ok message to the sender and calls `loop` with the count minus 1 and the queue. It does the same for `:release`. It checks if the count is 0. If it is, it checks if the queue is empty. If it is, it calls `loop` with the count plus 1 and the queue. Otherwise, it sends an ok message to the sender and calls `loop` with the count and the queue without the first element. It does the same for `count > 0`.

**Task 6** -- Scheduler actor

```elixir
defmodule Scheduler do
  def create_scheduler do
    spawn(fn -> scheduler_loop() end)
  end

  def schedule(pid, task) do
    send(pid, {:schedule, task})
  end

  defp scheduler_loop do
    Process.flag(:trap_exit, true)
    loop()
  end

  defp loop do
    receive do
      {:schedule, task} ->
        create_worker(task)

      {:EXIT, _pid, :normal} ->
        IO.puts("Task succesful : Miau")

      {:EXIT, _pid, task} ->
        IO.puts("Task fail")
        create_worker(task)
    end
    loop()
  end

  defp create_worker(task) do
    spawn_link(fn -> worker_loop(task) end)
  end

  defp worker_loop(task) do
    if :rand.uniform() < 0.5 do
      exit(:normal)
    else
      exit(task)
    end
  end

end
```

`Scheduler` is an actor that can schedule tasks. It uses pattern matching to check if the message is `{:schedule, task}`. If it is, it calls `create_worker` with the task. It does the same for `{:EXIT, _pid, :normal}` and `{:EXIT, _pid, task}`. It prints a message saying that the task was successful or failed and calls `create_worker` with the task. It calls `loop` after each receive. `create_worker` calls `spawn_link` with a function that calls `worker_loop` with the task. `worker_loop` checks if a random number is less than 0.5. If it is, it exits normally. Otherwise, it exits with the task. `scheduler_loop` calls `Process.flag` with `:trap_exit` and `true` and calls `loop`.

## P0W4

**Task 1** -- Supervised pull of workers

```elixir
defmodule Worker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def call(pid, msg) do
    GenServer.call(pid, msg)
  end

  def kill(pid) do
    GenServer.cast(pid, :kill)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, msg, state}
  end

  def handle_cast(:kill, state) do
    {:stop, :killed, state}
  end
end

defmodule Super do
  use Supervisor

  def start_link(num_workers) do
    Supervisor.start_link(__MODULE__, num_workers: num_workers, name: __MODULE__)
    |> elem(1)
  end

  def init(args) do
    children = Enum.map(1..args[:num_workers], fn i ->
      %{
        id: i,
        start: {Worker, :start_link, []}
      }
    end)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker_pid(pid, id) do
    Supervisor.which_children(pid)
    |> Enum.find(fn {i, _, _, _} -> i == id end)
    |> elem(1)
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end
end
```

`Worker` is a GenServer that can be called with a message and killed. It uses pattern matching to check if the message is `msg`. If it is, it replies with the message and the state. It does the same for `:kill`. It exits with `:killed` and the state. `Super` is a supervisor that can start a number of workers. It uses pattern matching to check if the message is `num_workers`. If it is, it creates a list of workers and calls `Supervisor.init` with the list and `strategy: :one_for_one`. `get_worker_pid` gets the children of the supervisor and finds the child with the id. It returns the pid of the child. `count` gets the children of the supervisor and returns the number of children.

**Task 2** -- String processing line

```elixir
defmodule StringProcessor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    |> elem(1)
  end

  def init(_) do
    children = [
      %{
        id: :split_worker,
        start: {SplitWorker, :start_link, []}
      },
      %{
        id: :replace_worker,
        start: {ReplaceWorker, :start_link, []}
      },
      %{
        id: :join_worker,
        start: {JoinWorker, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def process(msg) do
    msg
    |> SplitWorker.split()
    |> ReplaceWorker.replace()
    |> JoinWorker.join()
  end

  def count(pid) do
    Supervisor.count_children(pid)
  end
end

defmodule SplitWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def split(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, String.split(msg), state}
  end
end

defmodule ReplaceWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def replace(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    msg = Enum.map(msg, fn word ->
      String.downcase(word)
      |> String.replace("n", "{$}")
      |> String.replace("m", "n")
      |> String.replace("{$}", "m")
    end)

    {:reply, msg , state}
  end
end

defmodule JoinWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def join(msg) do
    GenServer.call(__MODULE__, msg)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(msg, _from, state) do
    {:reply, Enum.join(msg, " "), state}
  end
end
```

`StringProcessor` is a supervisor that can start three workers. It creates a list of workers and calls `Supervisor.init` with the list and `strategy: :one_for_all`. `process` calls `SplitWorker.split`, `ReplaceWorker.replace` and `JoinWorker.join` with the message. `count` gets the children of the supervisor and returns the number of children. `SplitWorker` is a GenServer that can split a string. It uses pattern matching to check if the message is `msg`. If it is, it replies with the string split into a list and the state. `ReplaceWorker` is a GenServer that can replace the letters `n` and `m` in a string. It uses pattern matching to check if the message is `msg`. If it is, it replies with the string with the letters replaced and the state. `JoinWorker` is a GenServer that can join a list of strings into a string. It uses pattern matching to check if the message is `msg`. If it is, it replies with the list joined into a string and the state.

**Task 3** -- Pulp Fiction

```elixir
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
```

`PulpFiction` is a supervisor that can start two workers. It creates a list of workers and calls `Supervisor.init` with the list and `strategy: :one_for_all`. `play` calls `Killer.ask` and then calls `play` again. `count` gets the children of the supervisor and returns the number of children. `Killer` is a GenServer that can ask a question. It uses pattern matching to check if the message is `:ask`. If it is, it replies with a random question from the list of questions and the state. `Guy` is a GenServer that can answer a question. It uses pattern matching to check if the message is `:answer`. If it is, it replies with a random answer from the list of answers and the state. If the answer is `What?`, it replies with `What?` and the state. If the answer is not `What?`, it replies with the answer and the state. If the message is `:kill`, it stops the GenServer. `Killer` has a warning message and a counter. If the counter is 4, it replies with the warning message. If the counter is 5, it replies with `BANG!` and calls `Guy.kill`. `Guy` has a list of answers. If the random number is greater than 0.6, it replies with a random answer from the list of answers. If the random number is less than 0.6, it replies with `What?`.

## P0W5

**Task 1** -- Quotes Web Scraper

```elixir
defmodule Quotes do

  def get_response do
    HTTPoison.get!("https://quotes.toscrape.com/")
  end

  def get_quotes do
    response = get_response()
    response.body
    |> Floki.find("div.quote")
    |> Enum.map(fn div ->
      %{
        quote: get_quote(div),
        author: get_author(div),
        tags: get_tags(div)
      }
    end)
  end

  def get_quote(div) do
    div
    |> Floki.find("span.text")
    |> Floki.text()
  end

  def get_author(div) do
    div
    |> Floki.find("small.author")
    |> Floki.text()
  end

  def get_tags(div) do
    div
    |> Floki.find("div.tags a.tag")
    |> Enum.map(fn tag ->
      Floki.text(tag)
    end)
  end

  def write_to_file() do
    File.write!("quotes.json", Jason.encode!(get_quotes()))
  end

end
```

`get_response` gets the response from the website. `get_quotes` gets the response from the website and then gets the body of the response. It then finds all the divs with the class `quote` and maps over them. It then gets the quote, author, and tags from each div and returns a map with the quote, author, and tags. `get_quote` gets the quote from the div. `get_author` gets the author from the div. `get_tags` gets the tags from the div. It then maps over the tags and gets the text from each tag. `write_to_file` gets the quotes and then encodes them to JSON and writes them to a file called `quotes.json`.

**Task 2** -- Star Wars API

```elixir
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
      [...]
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
```

Description: This project is a simple API that allows you to get, create, update, and delete movies from a database. The database is an ETS table. The API is built using Plug and Cowboy. The API is defined in the StarWarsApi.Router module. The database is defined in the StarWarsApi.InMemoryDb module. The database is started as a GenServer and is registered under the name StarWarsApi.InMemoryDb. The API uses the GenServer to access the database. The API is started as an Application and is registered under the name StarWarsApi. The API is started using the command `mix run --no-halt`. The API is stopped using the command Ctrl-C.

## Conclusion

After performing this laboratory work I have learned how to write in functional programming language Elixir. What is the actor model and how to use it with OTP library. Also I have learned how to use Plug and Cowboy libraries to create a web server. I have learned how to use ETS tables to store data in memory.

## Bibliography

1. [Elixir](https://elixir-lang.org/)
2. [Elixir School](https://elixirschool.com/en/)