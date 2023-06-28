defmodule TodoServerTest do
  use ExUnit.Case
  doctest TodoServer

  setup do
    server_pid = TodoServer.start()
    on_exit(fn -> TodoServer.stop(server_pid) end)
    {:ok, server_pid: server_pid}
  end

  test "add_entry - adds provided entries and returns them", state do
    TodoServer.add_entry(state[:server_pid], %{date: ~D[2020-01-01], title: "todo 1"})
    TodoServer.add_entry(state[:server_pid], %{date: ~D[2020-01-02], title: "todo 2"})

    assert TodoServer.entries(state[:server_pid], ~D[2020-01-01]) === [
             %{date: ~D[2020-01-01], title: "todo 1", id: 0}
           ]

    assert TodoServer.entries(state[:server_pid], ~D[2020-01-02]) === [
             %{date: ~D[2020-01-02], title: "todo 2", id: 1}
           ]
  end
end
