defmodule StreamDemo do
  @spec line_lengths(Path.t()) :: list(number())
  def line_lengths(path) do
    File.stream!(path)
    |> Stream.map(fn line -> String.length(line) end)
    |> Enum.to_list()
  end
end
