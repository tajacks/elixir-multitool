defmodule Multitool.Numbers do
  @moduledoc """
  The Numbers module holds helper functions for number operations
  such as primes and factors
  """
  @moduledoc since: "0.1.0"

  import Multitool.Collections.ListOperations

  def natural?(n) when is_number(n) and n < 0, do: false

  @doc """
  Evaluates if a number is greater than negative one and does not have a remainder

  ## Parameters 

      n: Integer to evaluate for naturalness 

  ## Examples

      iex> natural?(-5)
      false

      iex> natural?(7) 
      true

      iex> natural?(7.5)
      false

      iex> natural?(7.0)
      true
  """
  @doc since: "0.3.1"
  def natural?(n) when is_number(n), do: Kernel.trunc(n) == n

  def trim_left(n) when is_integer(n) and n < 0, do: trim_left(n * -1) * -1

  def trim_left(n) when is_integer(n) and n in 0..10, do: 0

  @doc """
  Returns the given number without the leftmost digit

  When the given number is between negative nine and nine, zero is returned

  ## Parameters 

      n: Integer to trim the leftmost digit off of

  ## Examples

      iex> trim_left(57689)
      7689

      iex> trim_left(7) 
      0

      iex> trim_left(-56788)
      -6788

      iex> trim_left(-3)
      0
  """
  @doc since: "0.3.1"
  def trim_left(n) when is_integer(n) do
    places = :math.log10(n) |> Kernel.trunc()
    powers = :math.pow(10, places) |> Kernel.trunc()
    rem(n, powers)
  end

  def trim_right(n) when is_integer(n) and n < 0, do: trim_right(n * -1) * -1

  def trim_right(n) when is_integer(n) and n in 0..9, do: 0

  @doc """
  Returns the given number without the rightmost digit

  When the given number is between negative nine and nine, zero is returned

  ## Parameters 

      n: Integer to trim the rightmost digit off of

  ## Examples

      iex> trim_right(57689)
      5768

      iex> trim_right(7) 
      0

      iex> trim_right(-56788)
      -5678

      iex> trim_right(-3)
      0
  """
  @doc since: "0.3.1"
  def trim_right(n) when is_integer(n), do: div(n, 10)

  def cycle(0), do: 0

  @doc """
  Shifts all digits one place to the right, bringing the right most digit to the leftmost position 

  If the operation of bringing the rightmost digit to the leftmost position would result in the leading number 
  of the resulting integer being a zero, the digits are repeatedly shifted until a zero is not in the 
  leftmost position

  ## Parameters 

      n: The integer to cycle

  ## Examples

      iex> cycle(57)
      75

      iex> cycle(-57) 
      -75

      iex> cycle(190)
      901
  """
  @doc since: "0.3.1"
  def cycle(n) when is_integer(n) do
    Integer.digits(n) |> shift() |> _cycle() |> Integer.undigits()
  end

  defp _cycle([0 | _tail] = digits), do: _cycle(shift(digits))

  defp _cycle(digits), do: digits

  def cycle(n, 0) when is_integer(n), do: n

  @doc """
  Shifts all digits to the right, repeated a given number of times.

  This operation operates the same as `cycle/1` regarding leading zeroes 

  If the operation of bringing the rightmost digit to the leftmost position would result in the leading number 
  of the resulting integer being a zero, the digits are repeatedly shifted until a zero is not in the 
  leftmost position

  ## Parameters 

      n: The integer to cycle
      c: The amount of times to apply the cycle operation

  ## Examples

      iex> cycle(57, 1)
      75

      iex> cycle(-57, 2) 
      -57

      iex> cycle(190, 2)
      190
  """
  @doc since: "0.3.1"
  def cycle(n, c) do
    n |> cycle() |> cycle(c - 1)
  end

  @doc """
  Generates a MapSet of numbers resulting from cycling the given number so each digit is in each position once

  This operation operates the same as `cycle/1` regarding leading zeroes 

  If the operation of bringing the rightmost digit to the leftmost position would result in the leading number 
  of the resulting integer being a zero, the digits are repeatedly shifted until a zero is not in the 
  leftmost position

  ## Parameters 

      n: The integer to generate cycles of

  ## Examples

      iex> cycles(123) |> MapSet.to_list()
      [123, 231, 312]

      iex> cycles(-57)  |> MapSet.to_list()
      [-75, -57]
  """
  @doc since: "0.3.1"
  def cycles(n) when is_integer(n) do
    cycles = abs(n) |> :math.log10() |> trunc()
    _cycles(n, cycles) |> MapSet.new()
  end

  defp _cycles(n, 0), do: [n]

  defp _cycles(n, c) do
    [n | _cycles(cycle(n), c - 1)]
  end
end
