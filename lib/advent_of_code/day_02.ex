defmodule AdventOfCode.Day02 do
  defp get_game_id(bool, game_id) do
    case bool do
      true -> String.to_integer(game_id)
      false -> 0
    end
  end

  defp part1_logic(game) do
    red = 12
    green = 13
    blue = 14
    [game, info] = String.split(game, ": ", trim: true)
    [_, game_id] = String.split(game, " ")
    info
    |> String.split("; ", trim: true)
    |> Enum.map(fn set ->
      String.split(set, ", ", trim: true)
    end)
    |> Enum.map(fn set ->
      Enum.map(set, fn each ->
        case String.split(each, " ", trim: true) do
        [count, "red"] -> red >= String.to_integer(count)
        [count, "green"] -> green >= String.to_integer(count)
        [count, "blue"] -> blue >= String.to_integer(count)
      end
      end)
    end)
    |> List.flatten()
    |> Enum.all?(fn x -> x == true end)
    |> get_game_id(game_id)
    |> dbg()
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&part1_logic/1)
    |> Enum.sum()
    |> dbg()
  end

  defp part2_logic(game) do
    [game, info] = String.split(game, ": ", trim: true)
    [_, _game_id] = String.split(game, " ")
    info
    |> String.split("; ", trim: true)
    |> Enum.map(fn set ->
      String.split(set, ", ", trim: true)
    end)
    |> Enum.map(fn set ->
      Enum.map(set, fn each ->
        case String.split(each, " ", trim: true) do
        [count, "red"] -> %{red: String.to_integer(count)}
        [count, "green"] -> %{green: String.to_integer(count)}
        [count, "blue"] -> %{blue: String.to_integer(count)}
      end
      end)
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn x, acc ->
      Map.merge(acc, x, fn _, v1, v2 -> max(v1, v2) end)
    end)
    |> Map.values()
    |> Enum.reduce(1, fn x, acc -> acc * x end)
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&part2_logic/1)
    |> Enum.sum()
    |> dbg()
  end
end
