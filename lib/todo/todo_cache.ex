defmodule TodoCache do
  use GenServer

  @spec start() :: :ok
  def start do
    {:ok, _} = GenServer.start(__MODULE__, nil, name: __MODULE__)
    :ok
  end

  @spec stop() :: :ok
  def stop do
    GenServer.stop(__MODULE__)
  end

  @spec find_todo_server_for_title(String.t()) :: pid()
  def find_todo_server_for_title(title) do
    GenServer.call(__MODULE__, {:server_for_title, title})
  end

  @impl GenServer
  def init(_init_arg) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_for_title, title}, _from, state) do
    case Map.fetch(state, title) do
      {:ok, server_pid} ->
        {:reply, server_pid, state}

      :error ->
        server_pid = TodoServer.start()
        {:reply, server_pid, Map.put(state, title, server_pid)}
    end
  end
end
