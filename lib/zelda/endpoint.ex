defmodule Zelda.Endpoint do
  use Plug.Router

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)
  @database [%{"id" => 1, "title" => "Hello"}, %{"id" => 2, "title" => "world!"}]
  @not_found %{"code" => 404, "message" => "Path Not Found!"}

  get "/" do
    send(conn, :ok, @database)
  end

  get "/:id" do
    send(conn, :ok, @database |> Enum.filter(fn it -> String.to_integer(id) == it["id"] end))
  end

  get _ do
    send(conn, :not_found, @not_found)
  end

  defp send(conn, code, data) when is_integer(code) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> send_resp(code, Jason.encode!(data))
  end

  defp send(conn, code, data) when is_atom(code) do
    code =
      case code do
        :ok -> 200
        :not_found -> 404
        :malformed_data -> 400
        :non_authenticated -> 401
        :forbidden_access -> 403
        :server_error -> 500
        :error -> 504
      end

    send(conn, code, data)
  end
end
