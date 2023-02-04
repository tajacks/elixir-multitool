defmodule MultiTool.CollectionsTest.ListOperationsTest do
  
  use ExUnit.Case, async: true

  doctest Multitool.Collections.ListOperations, import: true

  import Multitool.Collections.ListOperations

  test "can shift lists of numerous sizes" do    
    assert shift([]) == []
    assert shift([1]) == [1]
    assert shift([1, "a", :ok]) == [:ok, 1, "a"]
  end

  test "can generate all permutations" do
    assert permutations([1, 2, 3]) == [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
  end
end
