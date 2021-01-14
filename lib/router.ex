defmodule Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  @not_found %{"code" => 404, "message" => "Not Found!"}

  forward("/api/zelda", to: Zelda.Endpoint)

  match _ do
    send_resp(conn, 404, Jason.encode!(@not_found))
  end
end
