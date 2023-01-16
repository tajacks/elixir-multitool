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
      iec
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
      true -> Stream.iterate(2, &(&1 + 1)) |> Stream.filter(&prime?/1) |> Enum.take(n)
    end
  end

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
