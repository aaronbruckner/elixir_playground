defmodule TodoServer do
  use GenServer
  ###
  # Client API
  ###
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def stop do
    GenServer.stop(__MODULE__)
  end

  @spec add_entry(TodoList.newTodoEntry()) :: :ok
  def add_entry(entry) do
    GenServer.cast(__MODULE__, {:add_entry, entry})
  end

  @spec entries(Calendar.date()) :: list(TodoList.todoEntry())
  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date}, :infinity)
  end

  ###
  # Server API
  ###

  @impl GenServer
  def init(_init_arg) do
    {:ok, TodoList.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, todoList) do
    {:noreply, TodoList.add_entry(todoList, entry)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, todoList) do
    {:reply, TodoList.entries(todoList, date), todoList}
  end
end
