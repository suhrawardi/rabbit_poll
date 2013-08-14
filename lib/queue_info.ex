defmodule QueueInfo do

  def query(vhost) do
    "rabbitmqctl list_queues -p /#{vhost} name messages_ready messages_unacknowledged messages"
  end

  def get(query) do
    System.cmd(query)
  end

  def list(output) do
    String.split(output, "\n")
  end

  def splitted(list) do
    lc x inlist list, do: String.split(x, "\t")
  end

  def formatted(list) do
    lc [head|tail] inlist list, do: {head, tail}
  end

  def as_list(vhost) do
    vhost
      |> query
      |> get
      |> list
      |> splitted
      |> formatted
  end

  def filtered_list(vhost, queue) do
    Enum.filter(as_list(vhost), fn({x, _}) -> x == queue end)
  end

  def as_json(vhost, queue) do
    Jsonex.encode(filtered_list(vhost, queue))
  end
end
