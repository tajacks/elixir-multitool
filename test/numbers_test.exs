defmodule Multitool.NumbersTest do
  use ExUnit.Case, async: true

  doctest Multitool.Numbers.Primes, import: true
  doctest Multitool.Numbers.Factors, import: true
  doctest Multitool.Numbers.Triangular, import: true

  import Multitool.Numbers.Triangular
  import Multitool.Numbers.Factors
  import Multitool.Numbers.Primes

  # Prime

  test "prime numbers less than or equal to three are correct" do
    assert Enum.all?([-1, 0, 1], &prime?/1) == false
    assert Enum.all?([2, 3], &prime?/1) == true
  end

  test "prime numbers larger than three are correct" do
    assert prime?(22619) == true
    assert prime?(5849) == true
    assert prime?(5) == true
    assert prime?(14) == false
    assert prime?(14_538_464_538) == false
  end

  test "n primes where n is less than four are correct" do
    assert primes(0) == []
    assert primes(1) == [2]
    assert primes(2) == [2, 3]
    assert primes(3) == [2, 3, 5]
  end

  test "n primes where n is larger than four are correct" do
    assert primes(10) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  end

  test "nth prime where n is less than four is correct" do
    assert nth_prime(0) == nil
    assert nth_prime(1) == 2
    assert nth_prime(2) == 3
    assert nth_prime(3) == 5
  end

  test "nth prime where n is larger than four is correct" do
    assert nth_prime(10) == 29
    assert nth_prime(981) == 7727
  end

  # Factors
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

  # Triangular

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
