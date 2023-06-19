defmodule FlowControl do
  def greet_person(personTuple) do
    {:person, firstName, lastName} = personTuple
    "Hello #{firstName} #{lastName}!"
  end

  def get_sign(num) when is_number(num) and num > 0, do: :positive
  def get_sign(0), do: :zero
  def get_sign(num) when is_number(num) and num < 0, do: :negative

  def list_length([]), do: 0
  def list_length([_ | tail]), do: 1 + list_length(tail)

  def list_length_tail(list), do: list_length_tail(list, 0)
  defp list_length_tail([], length), do: length
  defp list_length_tail([_ | tail], count), do: list_length_tail(tail, count + 1)

  def range(first, last), do: range(first, last, [])
  defp range(first, last, values) when last < first, do: values
  defp range(first, last, values), do: range(first, last - 1, [last | values])
end
