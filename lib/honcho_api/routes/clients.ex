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

  post "/" do
    changeset = Client.changeset(%Client{}, conn.params)
    case HonchoApi.Repo.insert(changeset) do
      {:ok, client} ->
        conn
        |> render("show", %{client: client}, 201)
      {:error, changeset} ->
        conn
        |> render("error", %{changeset: changeset}, :unprocessable_entity)
    end
  end
end
