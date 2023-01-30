defmodule Multitool.NumbersTest.TriangularTest do
  
  use ExUnit.Case, async: true

  doctest Multitool.Numbers.Triangular, import: true

  test "nth triangle number where n is less than zero is zero" do
    assert nth_triangle_num(-1) == 0
  end

  test "nth triangle number where n is greater than zero is correct" do
    assert nth_triangle_num(5) == 15
    assert nth_triangle_num(100) == 5050
  end

  test "triangle numbers less than one are empty" do
    assert triangle_nums(0) == []
    assert triangle_nums(5) == [1, 3, 6, 10, 15]
  end


end
