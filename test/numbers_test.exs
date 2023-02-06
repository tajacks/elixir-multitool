defmodule Multitool.NumbersTest do
  use ExUnit.Case, async: true

  doctest Multitool.Numbers, import: true

  import Multitool.Numbers

  test "can remove left most digit from positive integer" do
    assert trim_left(45_679) == 5679
    assert trim_left(100) == 0
    assert trim_left(599_999) == 99_999
  end

  test "can remove right most digit from integer" do
    assert trim_right(45_679) == 4567
    assert trim_right(10) == 1
    assert trim_right(1) == 0
  end

  test "can cycle integer including zero" do
    assert cycle(12) == 21
    assert cycle(123) == 312
    assert cycle(12) |> cycle() == 12
    assert cycle(0) == 0
    assert cycle(120) == 201
  end

  test "can cycle integers including zero with count" do
    assert cycle(14, 0) == 14
    assert cycle(15, 1) == 51
    assert cycle(15, 2) == 15
    assert cycle(120, 1) == 201
    assert cycle(120, 2) == 120
  end

  test "can generate all cycles" do
    assert cycles(123) |> MapSet.to_list() |> Enum.sort() == Enum.sort([123, 312, 231])
    assert cycles(1041) |> MapSet.to_list() |> Enum.sort() == Enum.sort([1041, 1104, 4110])
    assert cycles(1230) |> MapSet.to_list() |> Enum.sort() == Enum.sort([1230, 3012, 2301])
  end
end
