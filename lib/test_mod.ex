defmodule MyMod do
  def test() do
    IO.puts("hello world 2")
  end

  @spec sum(number, number) :: number
  def sum(a, b), do: a + b
end
