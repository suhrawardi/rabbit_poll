defmodule RabbitPoll.Mixfile do
  use Mix.Project

  def project do
    [ app: :rabbit_poll,
      version: "0.0.1",
      dynamos: [RabbitPoll.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/rabbit_poll/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { RabbitPoll, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :jsonex,"2.0", github: "marcelog/jsonex", tag: "2.0" },
      { :dynamo, "0.1.0-dev", github: "elixir-lang/dynamo" } ]
  end
end
