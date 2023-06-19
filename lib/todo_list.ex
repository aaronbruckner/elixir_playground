defmodule TodoList do

  def new(), do: %{}

  def add_entry(todoList, date, title) do
    Map.update(todoList, date, [title], fn items -> [title | items] end)
  end

  def entries(todoList, date) do
    Map.get(todoList, date, [])
  end
end
