defmodule AsyncPlayground do
  @spec run_query(String.t()) :: String.t()
  def run_query(query) do
    # Simulate async task
    Process.sleep(1000)
    "<Query Result>: #{query}"
  end

  def async_query(query) do
    caller_pid = self()

    spawn(fn ->
      send(caller_pid, {:async_query_result, run_query(query)})
    end)
  end
end
