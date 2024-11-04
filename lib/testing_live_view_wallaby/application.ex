defmodule TestingLiveViewWallaby.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TestingLiveViewWallabyWeb.Telemetry,
      TestingLiveViewWallaby.Repo,
      {DNSCluster, query: Application.get_env(:testing_live_view_wallaby, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TestingLiveViewWallaby.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TestingLiveViewWallaby.Finch},
      # Start a worker by calling: TestingLiveViewWallaby.Worker.start_link(arg)
      # {TestingLiveViewWallaby.Worker, arg},
      # Start to serve requests, typically the last entry
      TestingLiveViewWallabyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestingLiveViewWallaby.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestingLiveViewWallabyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
