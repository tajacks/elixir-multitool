defmodule Multitool.Numbers.Triangular do
  @moduledoc """
  Provides operations for working with triangular numbers

  A triangular number is generated by adding the natural numbers up to 
  and including the number `n`.

  The 4th triangular number, for example, can be calculated as follows:

  `1 + 2 + 3 + 4 = 10`

  """
  @moduledoc since: "0.1.0"

  @doc """
  Returns a list of the first `n` triangle numbers, starting at one

  If `n` is less than one, an empty list is returned

  ## Parameters

      n: The number of triangle numbers to retrieve

  ## Examples

      iex> triangle_nums(3)
      [1, 3, 6]
      iex> triangle_nums(-1)
      []
      iex> triangle_nums(5)
      [1, 3, 6, 10, 15]
  """
  @doc since: "0.1.0"
  def triangle_nums(n) when n > 0 do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.take(n)
    |> Enum.map(&nth_triangle_num(&1))
  end

  def triangle_nums(_n), do: []

  @doc """
  Returns the nth triangle number where the first triangle number is one.

  If `n` is less than one, zero is returned


  ## Parameters

      n: The nth triangle number to retrieve

  ## Examples

      iex> nth_triangle_num(3)
      6
      iex> nth_triangle_num(-1)
      0
      iex> nth_triangle_num(34)
      595
  """
  @doc since: "0.1.0"
  def nth_triangle_num(n) when n > 0 do
    n + nth_triangle_num(n - 1)
  end

  def nth_triangle_num(_n), do: 0
end
