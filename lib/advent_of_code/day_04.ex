defmodule AdventOfCode.Day04 do
  def part1_logic(single_input) do
    [card, nums] = String.split(single_input, ": ", trim: true)
    [_, _card_id] = String.split(card, " ", trim: true)
    [answer, mine] = String.split(nums, " | ", trim: true)
    answer_list = String.split(answer, " ", trim: true)
    mine_list = String.split(mine, " ", trim: true)
    mine_list
    |> Enum.map(fn x ->
      cond do
        x in answer_list -> 1
        true -> 0
      end
    end)
    |> Enum.sum()
    |> dbg()
  end

  defp pow(n, base) do
    case n do
      n when n >= 2 -> base * Enum.reduce(1..n-1, fn _, acc -> acc * base end)
      1 -> 1
      0 -> 0
    end
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&part1_logic/1)
    |> Enum.map(&(pow(&1, 2)))
    |> dbg()
    |> Enum.sum()
    |> dbg()
  end

  @doc """
  Update the list of copies by the consecutive n number from index + 1

  example)
  copies = [1, 1, 1, 1, 1, 1]
  n = 4
  index = 0

  result = [1, 2, 2, 2, 2, 1]
  """
  @spec part2_logic(list, integer, integer) :: list
  defp part2_logic(copies, n, index) do
    card_id = index + 1
    update_card_ids = Enum.to_list(card_id+1..card_id+n)
    case n do
      0 -> copies
      n when n >= 1 ->
        Enum.with_index(copies, fn copy, i ->
          if i + 1 in update_card_ids do
            copy + Enum.at(copies, index)
          else
            copy
          end
        end)
    end
  end

  def part2(input) do
    split_input = String.split(input, "\n", trim: true)
    copies = List.duplicate(1, length(split_input))

    split_input
    |> Enum.map(&part1_logic/1)
    |> Enum.with_index()
    |> Enum.reduce(copies, fn {n, i}, acc ->
      part2_logic(acc, n, i)
    end)
    |> dbg()
    |> Enum.sum()
    |> dbg()

  end
end
