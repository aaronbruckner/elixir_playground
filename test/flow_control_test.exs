defmodule FlowControlTest do
  use ExUnit.Case
  doctest FlowControl

  test "greet_person returns the right response" do
    assert FlowControl.greet_person({:person, "John", "Smith"}) === "Hello John Smith!"
  end

  test "greet_person throws error if tuple isn't the right type" do
    assert_raise MatchError, fn -> FlowControl.greet_person({:animial, "kitty", "cat"}) end
  end

  test "get_sign returns :positive" do
    assert FlowControl.get_sign(4) === :positive
  end

  test "get_sign returns :zero" do
    assert FlowControl.get_sign(0) === :zero
  end

  test "get_sign returns :negative" do
    assert FlowControl.get_sign(-4) === :negative
  end

  test "list_length empty list" do
    assert FlowControl.list_length([]) === 0
  end

  test "list_length non-empty list" do
    assert FlowControl.list_length([1,2,3,4]) === 4
  end

  test "list_length_tail empty list" do
    assert FlowControl.list_length_tail([]) === 0
  end

  test "list_length_tail non-empty list" do
    assert FlowControl.list_length_tail([1,2,3,4]) === 4
  end

  test "range" do
    assert FlowControl.range(1, 5) === [1, 2, 3, 4, 5]
  end

  test "mixed_sum returns correct sum even with random elements" do
    assert FlowControl.mixed_sum([1, 2, "test", [], 3]) === 6
  end
end
