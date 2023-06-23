defmodule TodoList.CsvImporterTest do
  use ExUnit.Case
  doctest TodoList.CsvImporter

  test "newTodoListFromFile - builds todo list correctly" do
    todoList = TodoList.CsvImporter.newTodoListFromFile("test/mockFiles/mockTodoList.csv")

    assert TodoList.entries(todoList, ~D[2020-01-01]) === [
             %{date: ~D[2020-01-01], title: "todo 1", id: 0},
             %{date: ~D[2020-01-01], title: "todo 2", id: 1}
           ]

    assert TodoList.entries(todoList, ~D[2020-01-02]) === [
             %{date: ~D[2020-01-02], title: "todo 3", id: 2}
           ]
  end
end
