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
end
