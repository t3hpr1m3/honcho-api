defmodule HonchoApi.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  forward "/api/clients", to: HonchoApi.Routes.Clients

  match _ do
    send_resp(conn, 404, "oops")
  end
end
