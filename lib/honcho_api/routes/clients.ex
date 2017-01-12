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

  put "/:id" do
    client = Repo.get!(Client, id)
    changeset = Client.changeset(client, conn.params)
    case Repo.update(changeset) do
      {:ok, client} ->
        render(conn, "show", %{client: client})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error", %{changeset: changeset})
    end
  end

  match _ do
    send_resp(conn, 404, Poison.encode!(%{error: "Not Found"}))
  end
end
