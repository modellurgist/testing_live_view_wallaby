{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, TestingLiveViewWallabyWeb.Endpoint.url())

# ExUnit.configure(exclude: [:e2e])
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(TestingLiveViewWallaby.Repo, :manual)
