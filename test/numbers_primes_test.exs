defmodule Multitool.NumbersTest.PrimesTest do
  use ExUnit.Case, async: true

  doctest Multitool.Numbers.Primes, import: true

  import Multitool.Numbers.Primes

  test "prime numbers less than or equal to three are correct" do
    assert Enum.all?([-1, 0, 1], &prime?/1) === false
    assert Enum.all?([2, 3], &prime?/1) === true
  end

  test "prime numbers larger than three are correct" do
    assert prime?(22619) === true
    assert prime?(5849) === true
    assert prime?(5) === true
    assert prime?(14) === false
    assert prime?(14_538_464_538) === false
  end

  test "n primes where n is less than four are correct" do
    assert primes(0) === []
    assert primes(1) === [2]
    assert primes(2) === [2, 3]
    assert primes(3) === [2, 3, 5]
  end

  test "n primes where n is larger than four are correct" do
    assert primes(10) === [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  end

  test "nth prime where n is less than four is correct" do
    assert nth_prime(0) === nil
    assert nth_prime(1) === 2
    assert nth_prime(2) === 3
    assert nth_prime(3) === 5
  end

  test "nth prime where n is larger than four is correct" do
    assert nth_prime(10) === 29
    assert nth_prime(981) === 7727
  end

  test "primes before cases are correct" do
    assert primes_before(2) === []
    assert primes_before(9) === [7, 5, 3, 2]
    assert primes_before(2, 3) === []
    assert primes_before(9, 2) === [7, 5]
  end

  test "previous prime cases are correct" do
    assert previous_prime(13) === 11
    assert previous_prime(2) === nil
  end

  test "primes after cases are correct" do
    assert primes_after(10) |> Enum.take(1) === [11]
    assert primes_after(10, 2) === [11, 13]
  end

  test "next primes cases are correct" do
    assert next_prime(-5) === 2
    assert next_prime(57) === 59
  end
end
