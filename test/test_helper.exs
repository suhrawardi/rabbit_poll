Dynamo.under_test(RabbitPoll.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule RabbitPoll.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
