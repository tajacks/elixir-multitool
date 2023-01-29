defmodule Multitool.Numbers.Sequence do
  @moduledoc """
  Provides operations that generate sequences of numbers
  """
  @moduledoc since: "1.3.0"

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
