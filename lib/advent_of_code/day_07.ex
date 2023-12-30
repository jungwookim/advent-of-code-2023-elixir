defmodule AdventOfCode.Day07 do
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  defp make_basic_card_info(card, bid, joker) do
    %{}
    |> Map.put(
      :counts,
      Enum.frequencies(String.graphemes(card))
    )
    |> Map.put(:bid, String.to_integer(bid))
    |> Map.put(:card, card)
    |> Map.put(
      :labels,
      Enum.map(String.graphemes(card), fn x ->
        case x do
          "A" -> 14
          "K" -> 13
          "Q" -> 12
          "J" -> joker
          "T" -> 10
          _ -> String.to_integer(x)
        end
      end)
    )
  end

  defp base_card_type(counts) do
    case counts do
      [5] -> 7
      [4, 1] -> 6
      [3, 2] -> 5
      [3, 1, 1] -> 4
      [2, 2, 1] -> 3
      [2, 1, 1, 1] -> 2
      [1, 1, 1, 1, 1] -> 1
    end
  end

  defp determine_card_type(card, bid) do
    info = make_basic_card_info(card, bid, 11)
    counts = info |> Map.get(:counts) |> Map.delete("J") |> Map.values() |> Enum.sort(:desc)
    Map.put(info, :type, counts)
  end

  defp determine_card_type_part2(card, bid) do
    info = make_basic_card_info(card, bid, 1)
    num_of_jokers = info |> Map.get(:counts) |> Map.get("J", 0)

    counts_without_jokers =
      info |> Map.get(:counts) |> Map.delete("J") |> Map.values() |> Enum.sort(:desc)

    info
    |> Map.put(
      :type,
      case num_of_jokers do
        5 ->
          7

        4 ->
          7

        3 ->
          case counts_without_jokers do
            [2] -> 7
            [1, 1] -> 6
          end

        2 ->
          case counts_without_jokers do
            [3] -> 7
            [2, 1] -> 6
            [1, 1, 1] -> 4
          end

        1 ->
          case counts_without_jokers do
            [4] -> 7
            [3, 1] -> 6
            [2, 2] -> 5
            [2, 1, 1] -> 4
            [1, 1, 1, 1] -> 2
          end

        0 -> base_card_type(counts_without_jokers)
      end
    )
  end

  defp aggregate(result) do
    result
    |> Enum.with_index(1)
    |> Enum.map(fn {x, i} -> Map.get(x, :bid) * i end)
    |> Enum.sum()
  end

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn [card, bid] -> determine_card_type(card, bid) end)
    |> Enum.sort_by(&{Map.get(&1, :type), Map.get(&1, :labels)}, :asc)
    |> aggregate()
    |> dbg()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.map(fn [card, bid] -> determine_card_type_part2(card, bid) end)
    |> Enum.sort_by(&{Map.get(&1, :type), Map.get(&1, :labels)}, :asc)
    |> aggregate()
    |> dbg()
  end
end
