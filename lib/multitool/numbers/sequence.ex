defmodule Multitool.Numbers.Sequence do
  @moduledoc """
  Provides operations that generate sequences of numbers
  """
  @moduledoc since: "1.3.0"

  @doc """
  Returns a Stream that supplies the Fibonacci sequence, starting at `1`

  ## Examples

      iex> fibonacci() |> Enum.take(10)
      [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]  
  """
  @doc since: "1.3.0"
  def fibonacci(), do: Stream.unfold({1, 1}, fn {f1, f2} -> {f1, {f2, f1 + f2}} end)

  def fibonacci(n) when is_integer(n) and n < 1, do: []

  @doc """
  Returns a list of the first `n` integers in the Fibonacci sequence

  An empty list is returned if a number less than `1` is provided

  ## Parameters

      n: An integer, the number of digits in the sequence to retrieve

  ## Examples

      iex> fibonacci(10)
      [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]  
  """
  @doc since: "1.3.0"
  def fibonacci(n) when is_integer(n) and n > 0, do: fibonacci() |> Enum.take(n)

  def nth_fibonacci(n) when is_integer(n) and n < 0, do: nil

  def nth_fibonacci(0), do: 0

  @doc """
  Returns the integer at the nth position in the Fibonacci sequence, where the first integer in the sequence is 1

  When an integer less than zero is provided, `nil` is returned. When zero is provided, zero is returned. 
  All other values are computed

  ## Parameters

      n: An integer, the nth digit to retrieve from the Fibonacci sequence

  ## Examples

      iex> nth_fibonacci(10)
      55 

      iex> nth_fibonacci(-1)
      nil

      iex> nth_fibonacci(0)
      0
  """
  @doc since: "1.3.0"
  def nth_fibonacci(n), do: fibonacci() |> Stream.drop(n - 1) |> Enum.at(0)

  def collatz(1), do: [1]

  def collatz(n) when is_integer(n) and n < 1, do: []

  @doc """
  Provides the Collatz sequence starting with the given number and ending at 1


  Returns an empty list if a number less than 1 is provided

  ## Parameters

      n: Positive integer to begin the sequence at

  ## Examples

      iex> collatz(2)
      [2, 1]
    
      iex> collatz(0)
      []

      iex> collatz(3)
      [3, 10, 5, 16, 8, 4, 2, 1]
  """
  @doc since: "1.3.0"
  def collatz(n) when is_integer(n) do
    next =
      if rem(n, 2) == 0 do
        div(n, 2)
      else
        3 * n + 1
      end

    [n | collatz(next)]
  end

  def collatz_len(n) when is_integer(n) and n < 1, do: 0

  @doc """
  Given the integer `n`, returns the length of the resulting Collatz sequence, including the starting integer

  Returns zero when the provided integer is less than one. This method 
  is optimized for calculating the length over taking the length of the 
  resulting list of `collatz/1` 

  ## Parameters

      n: Positive integer

  ## Examples

      iex> collatz_len(2)
      2
    
      iex> collatz_len(0)
      0

      iex> collatz_len(3)
      8
  """
  @doc since: "1.3.0"
  def collatz_len(n), do: _collatz_len(n, 1)

  defp _collatz_len(1, c), do: c

  defp _collatz_len(n, c) do
    next =
      if rem(n, 2) == 0 do
        div(n, 2)
      else
        3 * n + 1
      end

    _collatz_len(next, c + 1)
  end
end
