defmodule HonchoApi.Routes.Clients do
  use HonchoApi.Route
  alias HonchoApi.Client
  alias HonchoApi.Repo

  get "/" do
    clients = Repo.all(Client)
    render(conn, "index", %{clients: clients})
  end

  get "/:id" do
    client = Repo.get!(Client, id)
    render(conn, "show", %{client: client})
  end

  post "/" do
    changeset = Client.changeset(%Client{}, conn.params)
    case Repo.insert(changeset) do
      {:ok, client} ->
        conn
        |> put_status(:created)
        |> render("show", %{client: client})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error", %{changeset: changeset})
    end
  end
end
