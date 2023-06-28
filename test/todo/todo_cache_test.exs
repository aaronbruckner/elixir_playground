defmodule TodoCacheTest do
  use ExUnit.Case
  doctest TodoCache

  setup do
    :ok = TodoCache.start()
    on_exit(fn -> TodoCache.stop() end)
  end

  test "find_todo_server_for_title - returns pids to different todo lists" do
    server_pid_1 = TodoCache.find_todo_server_for_title("title 1")
    server_pid_2 = TodoCache.find_todo_server_for_title("title 2")

    assert server_pid_1 !== server_pid_2
    assert server_pid_1 === TodoCache.find_todo_server_for_title("title 1")

    TodoServer.add_entry(server_pid_1, %{date: ~D[2020-01-01], title: "todo 1"})

    assert TodoServer.entries(server_pid_1, ~D[2020-01-01]) === [
             %{date: ~D[2020-01-01], title: "todo 1", id: 0}
           ]

    assert TodoServer.entries(server_pid_2, ~D[2020-01-01]) === []
  end
end
