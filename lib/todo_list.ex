defmodule TodoList do

  defstruct next_id: 0, entries: %{}

  @type newTodoEntry :: %{title: String.t(), date: Calendar.date()}

  @spec new() :: %TodoList{}
  def new(), do: %TodoList{}


  @spec add_entry(%TodoList{}, newTodoEntry()) :: %TodoList{}
  def add_entry(todoList, entry) do
    entry = Map.put(entry, :id, todoList.next_id)
    entires = Map.put(todoList.entries, todoList.next_id, entry)
    %TodoList{todoList | entries: entires, next_id: todoList.next_id + 1}
  end

  @spec update_entry(%TodoList{}, number(), newTodoEntry()) :: %TodoList{}
  def update_entry(todoList, id, entry) do
    entry = Map.put(entry, :id, id)
    entries = Map.update!(todoList.entries, id, fn _ -> entry end)
    %TodoList{todoList | entries: entries}
  end

  @spec entries(%TodoList{}, Calendar.date()) :: list(String.t())
  def entries(todoList, date) do
    Stream.map(todoList.entries, fn {_id, entry} -> entry end)
    |> Enum.filter(fn entry -> entry.date === date end)
  end

end
