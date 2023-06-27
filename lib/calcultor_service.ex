defmodule CalcultorService do
  def start do
    spawn(fn -> loop(0) end)
  end

  def send_add(server_pid, value) do
    send(server_pid, {:add, value})
  end

  def send_subtract(server_pid, value) do
    send(server_pid, {:sub, value})
  end

  def send_divide(server_pid, value) do
    send(server_pid, {:div, value})
  end

  def send_multiply(server_pid, value) do
    send(server_pid, {:mult, value})
  end

  def get_value(server_pid) do
    send(server_pid, {:value, self()})

    receive do
      {:value, value} -> value
    end
  end

  defp loop(state) do
    next_state =
      receive do
        msg -> process_message(state, msg)
      end

    loop(next_state)
  end

  defp process_message(state, {:add, value}), do: state + value

  defp process_message(state, {:sub, value}), do: state - value

  defp process_message(state, {:div, value}), do: state / value

  defp process_message(state, {:mult, value}), do: state * value

  defp process_message(state, {:value, caller_pid}) do
    send(caller_pid, {:value, state})
    state
  end
end
