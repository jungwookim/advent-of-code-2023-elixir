defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @tag :skip
  test "part1" do
    input = File.read!("priv/static/advent_of_code/input_01_part1.txt")
    result = part1(input)

    assert result
  end

  @tag :skip
  test "part2" do
    input = File.read!("priv/static/advent_of_code/input_01_part2.txt")
    result = part2(input)

    assert result
  end
end
