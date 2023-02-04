defmodule Multitool.Collections.ListOperations do
  @moduledoc """
  Useful operations when dealing with Lists  
  """
  @moduledoc since: "0.3.1"

  def permutations([]), do: [[]]

  @doc """
  Returns a List containing all permutations of the given List


  ## Parameters 

      list: The list to generate permutations of

  ## Examples

      iex> permutations(["a", "b"])
      [["a", "b"], ["b", "a"]]

      iex> permutations([])
      [[]]
  """
  @doc since: "0.3.1"
  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])

  def shift([]), do: []

  def shift([head | _tail = []]), do: [head]

  @doc """
  Returns a List where all elements of the given list are shifted one to the right. 


  The last item in the List becomes the head after this operation is complete

  ## Parameters 

      list: The List of items to shift one to the right

  ## Examples

      iex> shift(["a", "b", "c"])
      ["c", "a", "b"]

      iex> shift([1])
      [1]
  """
  @doc since: "0.3.1"
  def shift(list) when is_list(list),
    do: Enum.reverse(list) |> then(fn [head | tail] -> [head | Enum.reverse(tail)] end)
end
