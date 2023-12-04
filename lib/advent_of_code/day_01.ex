defmodule AdventOfCode.Day01 do

  defp part1_logic(words) do
    words
    |> Enum.map(fn word -> String.replace(word, ~r/[^0-9]/, "") end)
    |> Enum.map(fn only_digits_word ->
        digit_list = Enum.to_list(String.graphemes(only_digits_word))
        String.to_integer(hd(digit_list) <> hd(Enum.reverse(digit_list)))
      end)
    |> Enum.sum()
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> part1_logic()
  end


  def replace_digit(word) do
    word
    |> String.replace("one", "o1e")
    |> String.replace("two", "t2o")
    |> String.replace("three", "t3e")
    |> String.replace("four", "f4r")
    |> String.replace("five", "f5e")
    |> String.replace("six", "s6x")
    |> String.replace("seven", "s7n")
    |> String.replace("eight", "e8t")
    |> String.replace("nine", "n9e")
  end
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> dbg()
    |> Enum.map(&(replace_digit(&1)))
    |> dbg()
    |> part1_logic()
    |> dbg()
  end
end
