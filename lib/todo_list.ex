defmodule TodoList do

  @type t :: %{}

  @spec new() :: t()
  def new(), do: %{}

  @spec add_entry(t(), Calendar.date(), String.t()) :: t()
  def add_entry(todoList, date, title) do
    Map.update(todoList, date, [title], fn items -> [title | items] end)
  end

  @spec entries(t(), Calendar.date()) :: list(String.t())
  def entries(todoList, date) do
    Map.get(todoList, date, [])
  end
end
