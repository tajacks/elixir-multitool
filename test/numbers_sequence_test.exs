defmodule Multitool.NumbersTest.SequenceTest do
  use ExUnit.Case, async: true

  doctest Multitool.Numbers.Sequence, import: true

  import Multitool.Numbers.Sequence

  test "can calculate correct collatz sequences" do
    assert collatz(1) === [1]
    assert collatz(0) === []
    assert collatz(10) === [10, 5, 16, 8, 4, 2, 1]
    assert collatz(2) === [2, 1]
  end

  test "can calculate correct collatz sequence lengths" do
    assert collatz_len(0) === 0
    assert collatz_len(47) === 105
    assert collatz_len(99) === 26
    assert collatz_len(837_799) === 525
  end

  test "can get n terms of Fibonacci" do
    assert fibonacci(5) === [1, 1, 2, 3, 5]
    assert fibonacci(0) === []
    assert fibonacci(-5) === []
  end

  test "can get nth term of Fibonacci" do
    assert nth_fibonacci(64) === 10_610_209_857_723
    assert nth_fibonacci(-5) === nil
    assert nth_fibonacci(0) === 0
  end
end
