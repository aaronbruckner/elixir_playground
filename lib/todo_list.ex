defmodule TodoList do
  defstruct next_id: 0, entries: %{}

  @type t :: %__MODULE__{
          next_id: number(),
          entries: %{number() => todoEntry()}
        }
  @type newTodoEntry :: %{title: String.t(), date: Calendar.date()}
  @type todoEntry :: %{title: String.t(), date: Calendar.date(), id: number()}

  @spec new(list(t)) :: t
  def new(entries \\ []) do
    Enum.reduce(entries, %TodoList{}, fn entry, acc -> add_entry(acc, entry) end)
  end

  @spec add_entry(t, newTodoEntry) :: t
  def add_entry(todoList, entry) do
    entry = Map.put(entry, :id, todoList.next_id)
    entires = Map.put(todoList.entries, todoList.next_id, entry)
    %TodoList{todoList | entries: entires, next_id: todoList.next_id + 1}
  end

  @spec update_entry(t, number, newTodoEntry) :: t
  def update_entry(todoList, id, entry) do
    entry = Map.put(entry, :id, id)
    entries = Map.update!(todoList.entries, id, fn _ -> entry end)
    %TodoList{todoList | entries: entries}
  end

  @spec delete_entry(t, number) :: t
  def delete_entry(%{entries: entries} = todoList, id) do
    %TodoList{todoList | entries: Map.delete(entries, id)}
  end

  @spec entries(t, Calendar.date()) :: list(todoEntry)
  def entries(todoList, date) do
    Stream.map(todoList.entries, fn {_id, entry} -> entry end)
    |> Enum.filter(fn entry -> entry.date === date end)
  end

  @spec entries(t) :: list(t)
  def entries(todoList) do
    Enum.map(todoList.entries, fn {_id, entry} -> entry end)
  end
end

defimpl String.Chars, for: TodoList do
  def to_string(todoList) do
    TodoList.entries(todoList)
    |> Stream.map(fn entry -> entry.title end)
    |> Enum.join(",")
  end
end

defmodule TodoList.CsvImporter do
  @spec newTodoListFromFile(String.t()) :: %TodoList{}
  def newTodoListFromFile(path) do
    File.stream!(path)
    |> Stream.map(fn line -> String.trim(line) end)
    |> Enum.reduce(TodoList.new(), fn line, todoList ->
      [date, title] = String.split(line, ",")
      TodoList.add_entry(todoList, %{date: Date.from_iso8601!(date), title: title})
    end)
  end
end
