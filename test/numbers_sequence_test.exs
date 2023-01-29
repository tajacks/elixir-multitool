defmodule Multitool.Numbers.SequenceTest do
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
end
