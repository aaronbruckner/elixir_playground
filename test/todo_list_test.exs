defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "new - empty constructor returns something" do
    assert TodoList.new !== nil
  end

  test "entries - returns empty list for no dates" do
    assert TodoList.new |> TodoList.entries(~D[2020-01-01]) === []
  end

  test "add_entry - adds a single todo to one date" do
    todoList = TodoList.new()
    |> TodoList.add_entry(~D[2020-01-01], "todo 1")

    assert TodoList.entries(todoList, ~D[2020-01-01]) === ["todo 1"]
  end

  test "add_entry - adds multiple todos to a single date" do
    todoList = TodoList.new()
    |> TodoList.add_entry(~D[2020-01-01], "todo 1")
    |> TodoList.add_entry(~D[2020-01-01], "todo 2")

    assert TodoList.entries(todoList, ~D[2020-01-01]) === ["todo 2", "todo 1"]
  end

  test "add_entry - adds multiple todos to different dates" do
    todoList = TodoList.new()
    |> TodoList.add_entry(~D[2020-01-01], "todo 1")
    |> TodoList.add_entry(~D[2020-01-02], "todo 2")

    assert TodoList.entries(todoList, ~D[2020-01-01]) === ["todo 1"]
    assert TodoList.entries(todoList, ~D[2020-01-02]) === ["todo 2"]
  end

end
