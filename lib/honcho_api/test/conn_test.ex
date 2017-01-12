defmodule HonchoApi.ConnTest do
  defmacro __using__(_) do
    quote do
      import Plug.Conn
      import HonchoApi.ConnTest
    end
  end

  def build_conn do
    build_conn(:get, "/", nil)
  end

  def build_conn(method, path, params_or_body \\ nil) do
    Plug.Test.conn(method, path, params_or_body)
  end

  @http_methods [:get, :post, :put, :delete]

  for method <- @http_methods do
    defmacro unquote(method)(conn, path_or_action, params_or_body \\ nil) do
      method = unquote(method)
      quote do
        Plug.Adapters.Test.Conn.conn(unquote(conn), unquote(method),
                                     unquote(path_or_action),
                                     unquote(params_or_body))
          |> Plug.Conn.put_req_header("content-type", "application/json")
          |> HonchoApi.Router.call([])
      end
    end
  end

  def json_response(%Plug.Conn{resp_body: body}) do
    case Poison.decode(body) do
      {:ok, body} ->
        body
      {:error, {:invalid, token}} ->
        raise "could not decode JSON body, invalid token #{inspect token} in body:\n\n#{body}"
    end
  end
end
