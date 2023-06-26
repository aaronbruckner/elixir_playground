defmodule BasicServer do
  def start do
    spawn(&loop/0)
  end

  @spec send_async_query(pid(), String.t()) :: nil
  def send_async_query(server_pid, query) do
    send(server_pid, {:async_query, self(), query})
  end

  @spec response_async_query() :: String.t()
  def response_async_query do
    receive do
      {:response_async_query, result} -> result
    end

  end

  defp loop do
    receive do
      {:async_query, caller_pid, query} -> send(caller_pid, {:response_async_query, async_query(query)})
    end
    loop()
  end

  defp async_query(query) do
    Process.sleep(1000)
    "<AsyncResult>: #{query}"
  end
end
