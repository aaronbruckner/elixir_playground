defmodule TodoList do

  defstruct next_id: 0, entries: %{}

  @spec new() :: %TodoList{}
  def new(), do: %TodoList{}

  @spec add_entry(%TodoList{}, %{title: String.t(), date: Calendar.date()}) :: %TodoList{}
  def add_entry(todoList, entry) do
    entry = Map.put(entry, :id, todoList.next_id)
    entires = Map.put(todoList.entries, todoList.next_id, entry)
    %TodoList{todoList | entries: entires, next_id: todoList.next_id + 1}
  end

  @spec entries(%TodoList{}, Calendar.date()) :: list(String.t())
  def entries(todoList, date) do
    Stream.map(todoList.entries, fn {_id, entry} -> entry end)
    |> Enum.filter(fn entry -> entry.date === date end)
  end

end
