defmodule AdventOfCode.Day01 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn word -> String.replace(word, ~r/[^0-9]/, "") end)
    |> Enum.map(fn only_digits_word ->
        digit_list = Enum.to_list(String.graphemes(only_digits_word))
        String.to_integer(hd(digit_list) <> hd(Enum.reverse(digit_list)))
      end)
    |> Enum.sum()
  end


  def part2(_args) do
  end
end
