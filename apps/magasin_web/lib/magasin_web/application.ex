defmodule MagasinWeb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      MagasinWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: MagasinWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MagasinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
