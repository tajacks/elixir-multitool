defmodule Multitool.Numbers.Figurate do
  @moduledoc """
  Provides operations for working with figurate numbers
  """
  @moduledoc since: "0.3.1"

  import Multitool.Numbers

  def triangle(n) when is_integer(n) and n < 0, do: nil

  @doc """
  Given a positive integer n, returns the nth triangle number

  Negative integers return `nil`

  ## Parameters 

      n: Integer. The nth triangle number to return

  ## Examples

      iex> triangle(5)
      15

      iex> triangle(-4) 
      nil
  """
  @doc since: "0.3.1"
  def triangle(n) when is_integer(n) and n >= 0, do: (n * ((n + 1) / 2)) |> trunc()

  def triangles(n) when is_integer(n) and n < 1, do: []

  @doc """
  Returns a List of the first n triangle numbers

  Providing a negative integer returns an empty List

  ## Parameters 

      n: Integer. The number of triangle numbers to generate

  ## Examples

      iex> triangles(3)
      [1, 3, 6]

      iex> triangles(-4) 
      []
  """
  @doc since: "0.3.1"
  def triangles(n) when is_integer(n), do: Enum.map(1..n, &triangle/1)

  def triangle?(n) when is_integer(n) and n < 1, do: nil

  @doc """
  Given an Integer n, returns the position of the number in the triangular sequence

  Negative integers or integers not in the sequence return `nil`

  ## Parameters 

      n: Integer. The number to test for being a triangle number

  ## Examples

      iex> triangle?(630)
      35

      iex> triangle?(-4) 
      nil
      
      iex> triangle?(29) 
      nil
  """
  @doc since: "0.3.1"
  def triangle?(n) when is_integer(n) do
    ((:math.sqrt(8 * n + 1) - 1) / 2)
    |> natural_figurate_response()
  end

  def pentagonal(n) when is_integer(n) and n < 0, do: nil

  @doc """
  Given a positive integer n, returns the nth pentagonal number 

  Negative integers return `nil`

  ## Parameters 

      n: Integer. The nth pentagonal number to return

  ## Examples

      iex> pentagonal(5)
      35

      iex> pentagonal(-4) 
      nil
  """
  @doc since: "0.3.1"
  def pentagonal(n) when is_integer(n) and n >= 0, do: (n * ((3 * n - 1) / 2)) |> trunc()

  def pentagonals(n) when is_integer(n) and n < 1, do: []

  @doc """
  Returns a List of the first n pentagonal numbers

  Providing a negative integer returns an empty List

  ## Parameters 

      n: Integer. The number of pentagonal numbers to generate

  ## Examples

      iex> pentagonals(3)
      [1, 5, 12]

      iex> pentagonals(-4) 
      []
  """
  @doc since: "0.3.1"
  def pentagonals(n) when is_integer(n), do: Enum.map(1..n, &pentagonal/1)

  def pentagonal?(n) when is_integer(n) and n < 1, do: nil

  @doc """
  Given an Integer n, returns the position of the number in the pentagonal sequence

  Negative integers or integers not in the sequence return `nil`

  ## Parameters 

      n: Integer. The number to test for being a pentagonal number

  ## Examples

      iex> pentagonal?(70)
      7

      iex> pentagonal?(-4) 
      nil
      
      iex> pentagonal?(29) 
      nil
  """
  @doc since: "0.3.1"
  def pentagonal?(n) when is_integer(n) do
    ((:math.sqrt(24 * n + 1) + 1) / 6)
    |> natural_figurate_response()
  end

  @doc """
  Given a positive integer n, returns the nth hexagonal number

  Negative integers return `nil`

  ## Parameters 

      n: Integer. The nth hexagonal number to return

  ## Examples

      iex> hexagonal(5)
      45

      iex> hexagonal(-4) 
      nil
  """
  def hexagonal(n) when is_integer(n) and n < 0, do: nil

  def hexagonal(n) when is_integer(n) and n >= 0, do: n * (2 * n - 1)

  def hexagonals(n) when is_integer(n) and n < 1, do: []

  @doc """
  Returns a List of the first n hexagonal numbers

  Providing a negative integer returns an empty List

  ## Parameters 

      n: Integer. The number of hexagonal numbers to generate

  ## Examples

      iex> hexagonals(3)
      [1, 6, 15]

      iex> hexagonals(-4) 
      []
  """
  @doc since: "0.3.1"
  def hexagonals(n) when is_integer(n), do: Enum.map(1..n, &hexagonal/1)

  def hexagonal?(n) when is_integer(n) and n < 0, do: nil

  @doc """
  Given an Integer n, returns the position of the number in the hexagonal sequence

  Negative integers or integers not in the sequence return `nil`

  ## Parameters 

      n: Integer. The number to test for being a hexagonal number

  ## Examples

      iex> hexagonal?(630)
      18

      iex> hexagonal?(-4) 
      nil
      
      iex> hexagonal?(29) 
      nil
  """
  @doc since: "0.3.1"
  def hexagonal?(n) when is_integer(n) do
    ((:math.sqrt(8 * n + 1) + 1) / 4)
    |> natural_figurate_response()
  end

  defp natural_figurate_response(n) do
    case natural?(n) do
      true -> trunc(n)
      false -> nil
    end
  end
end
