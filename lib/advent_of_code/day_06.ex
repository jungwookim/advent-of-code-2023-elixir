defmodule AdventOfCode.Day06 do
  @doc """
  input:
  Time:      7  15   30
  Distance:  9  40  200
  """
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      case line do
        "Time:" <> times ->
          times
          |> String.split(" ", trim: true)
          |> Enum.map(fn time -> String.to_integer(time) end)
        "Distance:" <> distances ->
          distances
          |> String.split(" ", trim: true)
          |> Enum.map(fn distance -> String.to_integer(distance) end)
      end
    end)
    |> Enum.zip()
  end

  def part1(input) do
    input
    |> parse_input()
    |> Enum.map(fn {times, goal} ->
      Enum.map(0..times-1, fn time ->
        velocity = time
        distance = velocity * (times - time)
        {distance, goal}
      end)
    end)
    |> Enum.map(fn each ->
      Enum.filter(each, fn {distance, goal} -> distance > goal end)
    end)
    |> Enum.map(fn each -> Enum.count(each) end)
    |> Enum.reduce(&(&1 * &2))
    |> dbg()

  end

  def part2(input) do
    part1(input)
  end
end
