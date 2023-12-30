defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  @tag :skip
  test "part1" do
    input = File.read!("priv/static/advent_of_code/input_07_part1.txt")
    result = part1(input)

    assert result
  end

  # @tag :skip
  test "part2" do
    input = File.read!("priv/static/advent_of_code/input_07_part2.txt")
    result = part2(input)

    assert result
  end
end
