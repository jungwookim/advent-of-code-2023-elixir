defmodule AdventOfCode.Day08 do
  defp dir_to_int(dir) do
    case dir do
      "R" -> 1
      "L" -> 0
    end
  end

  defp process(maps, infinite_sequence, position, num, terminate_fn) do
    if terminate_fn.(position) do
      dbg(num)
    else
      dir = Enum.at(infinite_sequence, num)
      process(maps, infinite_sequence, elem(maps[position], dir_to_int(dir)), num + 1, terminate_fn)
    end
  end

  defp parse_input(input) do
    [instructions | for_maps] = String.split(input, "\n", trim: true)
    {Stream.cycle(String.graphemes(instructions)), for_maps}
  end

  defp parse_maps(for_maps) do
    Enum.reduce(for_maps, %{}, fn line, acc ->
      [position, directions] =
        String.split(
          line
          |> String.replace("(", "")
          |> String.replace(")", ""),
          " = ",
          trim: true
        )

      [left, right] = String.split(directions, ", ", trim: true)

      Map.put(acc, position, {left, right})
    end)
  end

  def part1(input) do
    {infinite_instructions, for_maps} = parse_input(input)
    maps = parse_maps(for_maps)
    start = "AAA"
    process(maps, infinite_instructions, start, 0, &(&1 === "ZZZ"))
  end

  defp lcm(x, y) do
    div(x * y, Integer.gcd(x, y))
  end

  def part2(input) do
    {infinite_instructions, for_maps} = parse_input(input)
    maps = parse_maps(for_maps)

    starts =
      maps
      |> Map.keys()
      |> Enum.map(fn key -> if String.ends_with?(key, "A"), do: key, else: nil end)
      |> Enum.filter(&(&1 != nil))

    starts
    |> dbg()
    |> Enum.map(fn start -> process(maps, infinite_instructions, start, 0, &(String.ends_with?(&1, "Z"))) end)
    |> dbg()
    |> Enum.reduce(1, &lcm/2)
    |> dbg()
  end
end
