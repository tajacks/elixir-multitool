defmodule Multitool.NumbersTest.FactorialTest do
  use ExUnit.Case, async: true

  doctest Multitool.Numbers.Factorial, import: true

  import Multitool.Numbers.Factorial

  test "invalid factorial is zero" do
    assert factorial(-600_000) === 0
    assert factorial(0) === 0
  end

  test "valid factorials are correct" do
    assert factorial(6) === 720
    assert factorial(15) === 1_307_674_368_000
  end
end
