defmodule Multitool.Numbers.Factors do
  @moduledoc """
  Provides operations for working with the factors of numbers
    
  A factor of a number `x` is any number which divides `x` without a remainder.

  If `x` was `10`, the factors of `x` would be `[1, 2, 5, 10]`

  """
  @moduledoc since: "0.1.0"

  def factors_of(n) when n < 1, do: []

  @doc """
  Given a number `n`, retrieve a list of all factors for that number

  If `n` is less than one, return an empty list. The resulting
  list is not sorted.


  ## Parameters

      n: The number to retrieve factors of 

  ## Examples

      iex> factors_of(3)
      [1, 3]
      iex> factors_of(0)
      []
      iex> factors_of(100)
      [1, 100, 2, 50, 4, 25, 5, 20, 10]
  """
  def factors_of(n) do
    upper_range = floor(:math.sqrt(n))
    factors = for x <- 1..upper_range, rem(n, x) == 0, do: [x, div(n, x)]
    List.flatten(factors) |> Enum.dedup()
  end
end
