defmodule QueueInfo do

  def query(vhost) do
    "rabbitmqctl list_queues -p /#{vhost} name messages_ready messages_unacknowledged messages"
  end

  def fetch(query) do
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

  def filtered(list, queue) do
    Enum.filter(list, fn({x, _}) -> x == queue end)
  end

  def as_json(list) do
    Jsonex.encode(list)
  end

  def get(vhost, queue) do
    vhost
      |> query
      |> fetch
      |> list
      |> splitted
      |> formatted
      |> filtered(queue)
      |> as_json
  end
end
