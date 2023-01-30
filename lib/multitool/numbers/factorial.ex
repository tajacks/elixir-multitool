defmodule Multitool.Numbers.Factorial do
  @moduledoc """
  Provides operations for working with the factorials of numbers
    
  The factorial of a number is the product of all numbers up to and including the number itself, starting at one
  """
  @moduledoc since: "0.3.0"

  def factorial(1), do: 1

  def factorial(n) when is_integer(n) and n < 1, do: 0

  @doc """
  Calculates the factorial of the given positive integer  

  If a non-positive integer is provided, zero is returned

  ## Parameters

      n: Positive integer to calculate the factorial of

  ## Examples

      iex> factorial(3)
      6
      iex> factorial(-5)
      0
      iex> factorial(10)
      3628800
  """
  def factorial(n) when is_integer(n) and n > 1, do: n * factorial(n - 1)
end
