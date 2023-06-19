defmodule StreamDemoTest do
  use ExUnit.Case
  doctest StreamDemo

  test "line_lengths returns list of line lengths" do
    assert StreamDemo.line_lengths("test/mockFiles/mockShortFile.txt") === [22, 5, 7, 53, 14]
  end

  test "longest_line_length returns longest line" do
    assert StreamDemo.longest_line_length("test/mockFiles/mockShortFile.txt") === 53
  end

  test "longest_line_length returns 0 for empty file" do
    assert StreamDemo.longest_line_length("test/mockFiles/mockEmptyFile.txt") === 0
  end

  test "longest_line returns the text for the longest line in the file" do
    assert StreamDemo.longest_line("test/mockFiles/mockShortFile.txt") === "There once was a man name Fred and no one liked him.\n"
  end

end
