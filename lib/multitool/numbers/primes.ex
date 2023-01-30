defmodule Multitool.Numbers.Primes do
  @moduledoc """
  Provides operations for working with prime numbers

  A number is prime if it has only two factors, itself and one
  """
  @moduledoc since: "0.1.0"

  def prime?(n) when n <= 3, do: n > 1

  @doc """
  Checks if the given number is a prime number.

  Returns `true` if the number is prime, `false` otherwise.
  Numbers less than two always return `false`

  ## Parameters 

      n: Integer to check for primality

  ## Examples

      iex> prime?(-1)
      false

      iex> prime?(1) 
      false

      iex> prime?(3)
      true

      iex> prime?(9800)
      false
  """
  @doc since: "0.1.0"
  def prime?(n) do
    cond do
      rem(n, 2) == 0 ->
        false

      rem(n, 3) == 0 ->
        false

      true ->
        Stream.unfold(5, fn x ->
          cond do
            x * x > n -> nil
            true -> {x, x + 6}
          end
        end)
        |> Enum.all?(&(rem(n, &1) != 0 && rem(n, &1 + 2) != 0))
    end
  end

  @doc """
  Generates a list of `n` prime numbers, starting at the first prime number, two.

  An empty list is returned when `n` is less than one

  ## Parameters

      n: The number of prime numbers to generate

  ## Examples

      iex> primes(-1)
      []

      iex> primes(1)
      [2]

      iex> primes(10)
      [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  """
  @doc since: "0.1.0"
  def primes(n) do
    cond do
      n < 1 -> []
      n == 1 -> [2]
      n == 2 -> [2, 3]
      n == 3 -> [2, 3, 5]
      true -> primes() |> Enum.take(n)
    end
  end

  @doc """
  Generates a Stream of prime numbers, starting at the first prime number, two.

  This operation will produce prime numbers until a terminating condition is reached

  ## Examples

      iex> primes() |> Enum.take(0) 
      []

      iex> primes() |> Enum.take(1)
      [2]

      iex> primes() |> Enum.take(10)
      [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  """
  @doc since: "1.2.0"
  def primes(), do: Stream.iterate(2, &(&1 + 1)) |> Stream.filter(&prime?/1)

  def primes_before(n) when is_integer(n) and n <= 2, do: []

  @doc """
  Returns a list of prime numbers that occur before the given integer `n`

  An empty list is returned when n is less than three

  ## Parameters

      n: An integer to retrieve preceding primes of

  ## Examples

      iex> primes_before(3)
      [2]

      iex> primes_before(2)
      []

      iex> primes_before(10)
      [7, 5, 3, 2]
  """
  @doc since: "1.3.0"
  def primes_before(n) when is_integer(n) do
    Stream.unfold(n - 1, fn x ->
      cond do
        x < 2 -> nil
        true -> {x, x - 1}
      end
    end)
    |> Stream.filter(&prime?/1)
    |> Enum.to_list()
  end

  def primes_before(c, _n) when is_integer(c) and c <= 2, do: []

  @doc """
  Returns a list of `n` primes that occur before, and not including, `c`


  ## Parameters

      c: Integer. The number to generate primes before
      n: Integer. The number of primes to generate

  ## Examples

      iex> primes_before(5, 2)
      [3, 2]

      iex> primes_before(2)
      []
  """
  @doc since: "1.3.0"
  def primes_before(c, n) when is_integer(n) and is_integer(c),
    do: primes_before(c) |> Enum.take(n)

  def previous_prime(c) when is_integer(c) and c < 3, do: nil

  def previous_prime(c) when is_integer(c), do: primes_before(c, 1) |> hd()

  @doc """
  Returns a Stream that returns prime numbers that occur after the given number

  This operation will produce prime numbers until a terminating condition is reached

  ## Parameters

       n: An integer to generate primes after

  ## Examples

      iex> primes_after(2) |> Enum.take(1)
      [3]

      iex> primes_after(0) |> Enum.take(2)
      [2, 3]
  """
  @doc since: "1.3.0"
  def primes_after(n) when is_integer(n) do
    start =
      if n < 1 do
        1
      else
        n + 1
      end

    Stream.iterate(start, &(&1 + 1))
    |> Stream.filter(&prime?/1)
  end

  @doc """
  Returns a list of `n` primes that occur after, and not including, `c`


  ## Parameters

      c: Integer. The number to generate primes after
      n: Integer. The number of primes to generate

  ## Examples

      iex> primes_after(2, 1)
      [3]

      iex> primes_after(0, 2)
      [2, 3]
  """
  @doc since: "1.3.0"
  def primes_after(c, n) when is_integer(n) and is_integer(c), do: primes_after(c) |> Enum.take(n)

  @doc """
  Returns the next prime number to follow `c`


  ## Parameters

      c: Integer. The number to get the next prime after

  ## Examples

      iex> next_prime(0)
      2

      iex> next_prime(59651)
      59659 
  """
  @doc since: "1.3.0"
  def next_prime(c), do: primes_after(c, 1) |> hd()

  @doc """
  Returns the nth prime number, where the first prime number is two.

  Returns `nil` when `n` is less than one

  ## Parameters

      n: The nth prime number to retrieve

  ## Examples

      iex> nth_prime(3)
      5
      iex> nth_prime(-1)
      nil
      iex> nth_prime(98764)
      1282201
  """
  @doc since: "0.1.0"
  def nth_prime(n) do
    cond do
      n < 1 ->
        nil

      n == 1 ->
        2

      n == 2 ->
        3

      n == 3 ->
        5

      true ->
        Stream.iterate(2, &(&1 + 1))
        |> Stream.filter(&prime?/1)
        |> Stream.drop(n - 1)
        |> Enum.take(1)
        |> hd()
    end
  end
end
