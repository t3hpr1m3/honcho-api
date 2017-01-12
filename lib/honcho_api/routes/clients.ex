defmodule HonchoApi.Routes.Clients do
  use HonchoApi.Route
  alias HonchoApi.Client

  get "/" do
    clients = HonchoApi.Repo.all(Client)
    render(conn, "index", %{clients: clients})
  end

  get "/:id" do
    client = HonchoApi.Repo.get!(Client, id)
    render(conn, "show", %{client: client})
  end
end
