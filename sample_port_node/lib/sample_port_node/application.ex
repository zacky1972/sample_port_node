defmodule SamplePortNode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :rand.seed(:exsss)

    children = [
      # Starts a worker by calling: SamplePortNode.Worker.start_link(arg)
      # {SamplePortNode.Worker, arg}
      SamplePortNode
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SamplePortNode.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
