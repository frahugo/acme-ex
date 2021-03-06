defmodule MagasinWeb.Endpoint do
  @moduledoc false

  use Phoenix.Endpoint, otp_app: :magasin_web

  socket "/socket", MagasinWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Static,
    at: "/",
    from: :magasin_web,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt doc)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_magasin_web_key",
    signing_salt: "wko8ywjz"

  plug MagasinWeb.Router

  # Callback invoked for dynamically configuring the endpoint.

  # It receives the endpoint configuration and checks if
  # configuration should be loaded from the system environment.
  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
