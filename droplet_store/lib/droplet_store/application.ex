defmodule DropletStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DropletStore.Repo,
      # Start the Telemetry supervisor
      DropletStoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DropletStore.PubSub},
      # Start the Endpoint (http/https)
      DropletStoreWeb.Endpoint
      # Start a worker by calling: DropletStore.Worker.start_link(arg)
      # {DropletStore.Worker, arg}
    ]

    DropletStore.KafkaLib.start_client()
    
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DropletStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DropletStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
