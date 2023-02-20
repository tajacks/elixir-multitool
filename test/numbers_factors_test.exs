defmodule Multitool.NumbersTest.FactorsTest do
  use ExUnit.Case, async: true

  doctest Multitool.Numbers.Factors, import: true

  import Multitool.Numbers.Factors

  test "factors of numbers smaller than one is empty list" do
    assert factors_of(-1) == []
    assert factors_of(0) == []
  end

  test "factors of numbers larger than one are correct" do
    assert factors_of(10) |> Enum.sort() == [1, 2, 5, 10]
    assert factors_of(99) |> Enum.sort() == [1, 3, 9, 11, 33, 99]
    assert factors_of(13) |> Enum.sort() == [1, 13]
    assert factors_of(100) |> Enum.sort() == [1, 2, 4, 5, 10, 20, 25, 50, 100]
  end

  test "can compute aliquot sum of positive number" do
    assert aliquot_sum(284) === 220
    assert aliquot_sum(10_000) === 14_211
  end

  test "can classify numbers of all types" do
    assert classify(100) === :abundant
    assert classify(14) === :deficient
    assert classify(8_589_869_056) === :perfect
  end

  test "sums of type with invalid number is empty" do
    assert sums_of_type(-5, :abundant) === []
    assert sums_of_type(-50_000, :deficient) === []
    assert sums_of_type(0, :perfect) === []
  end

  test "sums of type are correct" do
    assert sums_of_type(100, :abundant) === [{12, 88}, {20, 80}, {30, 70}, {40, 60}]
    assert sums_of_type(5, :deficient) === [{1, 4}, {2, 3}]
    assert sums_of_type(12, :perfect) === [{6, 6}]
    assert sums_of_type(13, :perfect) === []
  end

  test "can find sums of type in range" do
    assert sums_in(1..25, :abundant) === [24]
    assert sums_in(1..5, :deficient) === [2, 3, 4, 5]
    assert sums_in(1..1000, :perfect) === [12, 34, 56, 502, 524, 992]
    assert sums_in(1000..1100, :perfect) === []
  end

  test "all sums above 28123 can be represented as abundant sum" do
    x = 28_563..679_034
    assert Enum.to_list(x) === sums_in(x, :abundant)
  end

  test "range spans guaranteed abundant sums" do
    assert sums_in(28_122..28_124, :abundant) == [28_122, 28_123, 28_124]
  end

  test "sum type abundant above 28123 is always true" do
    assert 28_124..50_000 |> Enum.all?(&sum_type?(&1, :abundant))
  end

  test "sum type of any kind below 1 is false" do
    assert sum_type?(-5, :perfect) === false
    assert sum_type?(-5, :abundant) === false
    assert sum_type?(-5, :deficient) === false
  end

  test "can identify sums of type" do
    assert sum_type?(24, :abundant) === true
    assert sum_type?(12, :perfect) === true
    assert sum_type?(14, :deficient) === true
  end

  test "can classify amicable numbers" do
    assert amicable?(220, 284) === true
    assert amicable?(197, 156) === false
    assert amicable?(-220, 284) === false
    assert amicable?(220, 220) === false
  end
end
