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
    |> TodoList.add_entry(%{date: ~D[2020-01-01], title: "todo 1"})

    assert TodoList.entries(todoList, ~D[2020-01-01]) === [%{date: ~D[2020-01-01], title: "todo 1", id: 0}]
  end

  test "add_entry - adds multiple todos to a single date" do
    todoList = TodoList.new()
    |> TodoList.add_entry(%{date: ~D[2020-01-01], title: "todo 1"})
    |> TodoList.add_entry(%{date: ~D[2020-01-01], title: "todo 2"})

    assert TodoList.entries(todoList, ~D[2020-01-01]) === [%{date: ~D[2020-01-01], title: "todo 1", id: 0}, %{date: ~D[2020-01-01], title: "todo 2", id: 1}]
  end

  test "add_entry - adds multiple todos to different dates" do
    todoList = TodoList.new()
    |> TodoList.add_entry(%{date: ~D[2020-01-01], title: "todo 1"})
    |> TodoList.add_entry(%{date: ~D[2020-01-02], title: "todo 2"})

    assert TodoList.entries(todoList, ~D[2020-01-01]) === [%{date: ~D[2020-01-01], title: "todo 1", id: 0}]
    assert TodoList.entries(todoList, ~D[2020-01-02]) === [%{date: ~D[2020-01-02], title: "todo 2", id: 1}]
  end

  test "update_entry - finds exisitng entry and updates it" do
    todoList = TodoList.new()
    |> TodoList.add_entry(%{date: ~D[2020-01-01], title: "todo 1"})
    |> TodoList.add_entry(%{date: ~D[2020-01-02], title: "todo 2"})

    [entry | _] = TodoList.entries(todoList, ~D[2020-01-01])

    todoList = TodoList.update_entry(todoList, entry.id, %{date: ~D[2020-01-03], title: "todo 3"})

    assert TodoList.entries(todoList, ~D[2020-01-01]) === []
    assert TodoList.entries(todoList, ~D[2020-01-03]) === [%{date: ~D[2020-01-03], title: "todo 3", id: 0}]
  end

  test "update_entry - throws error if id doesn't exist" do
    assert_raise KeyError, fn -> TodoList.new()
    |> TodoList.update_entry(99, %{date: ~D[2020-01-01], title: "todo 1"}) end

  end
end
