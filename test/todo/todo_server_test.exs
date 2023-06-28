defmodule TodoServerTest do
  use ExUnit.Case
  doctest TodoServer

  setup do
    assert {:ok, _} = TodoServer.start()
    on_exit(fn -> TodoServer.stop() end)
    :ok
  end

  test "add_entry - adds provided entries and returns them" do
    TodoServer.add_entry(%{date: ~D[2020-01-01], title: "todo 1"})
    TodoServer.add_entry(%{date: ~D[2020-01-02], title: "todo 2"})

    assert TodoServer.entries(~D[2020-01-01]) === [
             %{date: ~D[2020-01-01], title: "todo 1", id: 0}
           ]

    assert TodoServer.entries(~D[2020-01-02]) === [
             %{date: ~D[2020-01-02], title: "todo 2", id: 1}
           ]
  end
end
