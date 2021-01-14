defmodule Zelda do
  @moduledoc false
  use Application

  require Logger

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: port()]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zelda.Supervisor]

    Logger.info("The server listening at port: #{port()}")
    Supervisor.start_link(children, opts)
  end

  # Call environment variables here.
  defp port, do: Application.get_env(:app, :port, 4000)
end
