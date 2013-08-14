defmodule ApplicationRouter do
  use Dynamo.Router

  get "/" do
    render conn, "index.html"
  end

  get "/:vhost/:queue" do
    cmd = "rabbitmqctl list_queues -p /#{vhost} name messages_ready messages_unacknowledged messages"
    msg = System.cmd(cmd)
    list = String.split(msg, "\n")
    value = lc x inlist list, do: String.split(x, "\t")
    value2 = lc [head|tail] inlist value, do: {head, tail}
    value3 = Enum.filter(value2, fn({x, _}) -> x == queue end)
    json = Jsonex.encode(value3)
    conn.send(200, json)
  end
end
