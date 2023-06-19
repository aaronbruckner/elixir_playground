defmodule StreamDemoTest do
  use ExUnit.Case
  doctest StreamDemo

  test "greet_person returns the right response" do
    assert StreamDemo.line_lengths("test/mockFiles/mockShortFile.txt") === [22, 5, 7, 53, 14]
  end

end
