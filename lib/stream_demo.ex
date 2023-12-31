defmodule StreamDemo do
  @spec line_lengths(Path.t()) :: list(number())
  def line_lengths(path) do
    File.stream!(path)
    |> Stream.map(fn line -> String.length(line) end)
    |> Enum.to_list()
  end

  def longest_line_length(path) do
    case line_lengths(path) do
      [] -> 0
      lengths -> Enum.max(lengths)
    end
  end

  @spec longest_line(Path.t()) :: String.t()
  def longest_line(path) do
    {_length, longestLine} =
      File.stream!(path)
      |> Stream.map(fn line -> {String.length(line), line} end)
      |> Enum.max_by(&elem(&1, 0))

    longestLine
  end
end
