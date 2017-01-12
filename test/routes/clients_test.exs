defmodule HonchoApi.Routes.ClientsTest do
  use HonchoApi.ConnCase
  alias HonchoApi.Views.ClientsView
  import HonchoApi.Factory

  setup context do
    [conn: build_conn()]
  end

  describe "GET /" do

    setup context do
      client = insert(:client)

      conn = get context.conn, "/api/clients/"

      [client: client, conn: conn]
    end

    test "responds with 200 (ok)", context do
      assert context.conn.status == Plug.Conn.Status.code(200)
    end

    test "renders a list of clients", context do
      assert json_response(context.conn) == render_json(ClientsView, "index", %{clients: [context.client]})
    end
  end

  describe "GET /:id" do

    setup context do
      client = insert(:client)

      conn = get context.conn, "/api/clients/#{client.id}"

      [client: client, conn: conn]
    end

    test "responds with 200 (ok)", context do
      assert context.conn.status == Plug.Conn.Status.code(200)
    end

    test "renders a single client", context do
      assert json_response(context.conn) == render_json(ClientsView, "show", %{client: context.client})
    end
  end

  describe "POST / when creation succeeds" do

    setup context do
      client_params = params_for(:client)

      conn = post context.conn, "/api/clients/", client_params

      [client_params: client_params, conn: conn]
    end

    test "responds with 201 (created)", context do
      assert context.conn.status == Plug.Conn.Status.code(201)
    end

    test "creates a client" do
      assert HonchoApi.Repo.aggregate(HonchoApi.Client, :count, :id) == 1
    end

    test "renders the client", context do
      client = HonchoApi.Repo.one(HonchoApi.Client)

      assert json_response(context.conn) == render_json(ClientsView, "show", %{client: client})
    end
  end

  describe "POST / when creation fails" do
    setup context do
      client_params = params_for(:client, name: "")

      conn = post context.conn, "/api/clients/", client_params

      [client_params: client_params, conn: conn]
    end

    test "responds with 422 (unprocessable entity)", context do
      assert context.conn.status == Plug.Conn.Status.code(:unprocessable_entity)
    end

    test "does not create a client" do
      assert HonchoApi.Repo.aggregate(HonchoApi.Client, :count, :id) == 0
    end

    test "renders an error", context do
      client = HonchoApi.Repo.one(HonchoApi.Client)

      assert match?(%{"errors" => _}, json_response(context.conn))
    end
  end
end
