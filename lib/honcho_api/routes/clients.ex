defmodule HonchoApi.Routes.Clients do
  use HonchoApi.Route
  alias HonchoApi.Client

  get "/" do
    clients = HonchoApi.Repo.all(Client)
    render(conn, "index.json", %{ clients: clients })
  end
end
