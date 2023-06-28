defmodule TodoServer do
  use GenServer
  ###
  # Client API
  ###
  @spec start() :: pid()
  def start do
    {:ok, pid} = GenServer.start(__MODULE__, nil)
    pid
  end

  @spec stop(pid()) :: :ok
  def stop(server_pid) do
    GenServer.stop(server_pid)
  end

  @spec add_entry(pid(), TodoList.newTodoEntry()) :: :ok
  def add_entry(server_pid, entry) do
    GenServer.cast(server_pid, {:add_entry, entry})
  end

  @spec entries(pid(), Calendar.date()) :: list(TodoList.todoEntry())
  def entries(server_pid, date) do
    GenServer.call(server_pid, {:entries, date}, :infinity)
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
