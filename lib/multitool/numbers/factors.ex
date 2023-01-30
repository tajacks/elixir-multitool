defmodule Multitool.Numbers.Factors do
  @moduledoc """
  Provides operations for working with the factors of numbers
    
  A factor of a number `x` is any number which divides `x` without a remainder.

  If `x` was `10`, the factors of `x` would be `[1, 2, 5, 10]`

  """
  @moduledoc since: "0.1.0"

  def factors_of(n) when is_integer(n) and n < 1, do: []

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
  @doc since: "0.1.0"
  def factors_of(n) when is_integer(n) do
    upper_range = floor(:math.sqrt(n))
    factors = for x <- 1..upper_range, rem(n, x) == 0, do: [x, div(n, x)]
    List.flatten(factors) |> Enum.dedup()
  end

  @doc """
  Given a number `n`, calculates the sum of all proper divisors of `n`, other than `n` itself

  ## Parameters

      n: A non-negative integer

  ## Examples

      iex> aliquot_sum(3)
      1
      iex> aliquot_sum(12)
      16
      iex> aliquot_sum(100)
      117
  """
  def aliquot_sum(n) when is_integer(n) and n > 0, do: Enum.sum(factors_of(n)) - n

  @doc """
  Given a number `n`, classifies `n` as either pefect, abundant, or deficient

  If the aliquot sum of `n` is equal to `n`, `n` is perfect. If the sum exceeds
  `n`, it is abundant. Otherwise, it is deficient

  ## Parameters

      n: A non-negative integer

  ## Examples

      iex> classify(3)
      :deficient
      iex> classify(12)
      :abundant
      iex> classify(28)
      :perfect
  """
  def classify(n) when is_integer(n) and n > 0 do
    case aliquot_sum(n) do
      ^n -> :perfect
      x when x > n -> :abundant
      _ -> :deficient
    end
  end

  def sums_of_type(n, _) when is_integer(n) and n < 1, do: []

  @doc """
  Given an integer `n` and `sum_type`, returns a list of tuples containg two numbers of the given type which sum to equal `n`

  If no two numbers of the given type sum to `n`, an empty list is returned. An empty list 
  is returned for integers below one

  ## Parameters

      n: An integer
      sum_type: An atom of either :abundant, :deficient, or :perfect

  ## Examples

      iex> sums_of_type(100, :abundant)
      [{12, 88}, {20, 80}, {30, 70}, {40, 60}]
      iex> sums_of_type(5, :deficient)
      [{1, 4}, {2, 3}]
      iex> sums_of_type(12, :perfect)
      [{6, 6}]
  """
  def sums_of_type(n, sum_type) when is_integer(n) and n > 0 and is_atom(sum_type) do
    Stream.filter(1..(n - 1), &(classify(&1) == sum_type))
    |> Stream.filter(&(classify(n - &1) == sum_type))
    |> Stream.map(&[&1, n - &1])
    |> Stream.map(&Enum.sort(&1))
    |> Stream.uniq()
    |> Stream.map(fn [head | tail] -> {head, hd(tail)} end)
    |> Enum.to_list()
  end

  def sums_in(%Range{} = range, :abundant) when range.first > 28123, do: Enum.to_list(range)

  def sums_in(%Range{} = range, :abundant) when range.first < 28123 and range.last >= 28123 do
    [sums_in(range.first..28122, :abundant) | Enum.to_list(28123..range.last)] |> List.flatten()
  end

  @doc """
  Given a range `range`, returns a list of integers that can be represented as the sum of two abundant numbers

  If no numbers in the range are the sum of two abundant numbers,
  an empty list is returned

  ## Parameters

      range: An integer range

  ## Examples

      iex> sums_in(1..25, :abundant)
      [24]
      iex> sums_in(1..5, :deficient)
      [2, 3, 4, 5]
      iex> sums_in(1..1000, :perfect)
      [12, 34, 56, 502, 524, 992]
  """
  def sums_in(%Range{} = range, sum_type) do
    sum_pool = _sums_pool_helper(range, sum_type)

    range
    |> Stream.filter(&Enum.any?(sum_pool, fn x -> MapSet.member?(sum_pool, &1 - x) end))
    |> Enum.to_list()
  end

  def sum_type?(n, :abundant) when is_integer(n) and n > 28123, do: true

  def sum_type?(n, _sum_type) when is_integer(n) and n < 1, do: false

  @doc """
  Given an integer `n` and `sum_type`, returns true if `n` can be represented as the sum of two numbers of the given type

  Always returns true if n is greater than 28123 and the type is abundant. False if less than one. All other values
  are computed

  ## Parameters

      n: An integer
      sum_type: An atom of either :abundant, :deficient, or :perfect

  ## Examples

      iex> sum_type?(24, :abundant)
      true
      iex> sum_type?(12, :perfect)
      true
      iex> sum_type?(14, :deficient)
      true
  """
  def sum_type?(n, sum_type) when is_integer(n) do
    Stream.filter(1..(n - 1), &(classify(&1) == sum_type))
    |> Stream.filter(&(classify(n - &1) == sum_type))
    |> Enum.any?()
  end

  defp _sums_pool_helper(%Range{} = range, sum_type) do
    1..range.last
    |> Stream.filter(&(classify(&1) == sum_type))
    |> MapSet.new()
  end
end
