defmodule ApplicationRouter do
  use Dynamo.Router

  get "/" do
    render conn, "index.html"
  end

  get "/:vhost/:queue" do
    conn.send(200, QueueInfo.get(vhost, queue))
  end
end
