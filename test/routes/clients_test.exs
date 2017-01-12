defmodule HonchoApi.Routes.ClientsTest do
  use HonchoApi.ConnCase
  alias HonchoApi.Views.ClientsView
  import HonchoApi.Factory

  setup do
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
      assert match?(%{"errors" => _}, json_response(context.conn))
    end
  end

  describe "PUT / when update succeeds" do
    setup context do
      client_params = %{name: "New Name"}
      client = insert(:client, name: "Old Name")

      conn = put context.conn, "/api/clients/#{client.id}", client_params

      [client: client, client_params: client_params, conn: conn]
    end

    test "responds with 200 (ok)", context do
      assert context.conn.status == Plug.Conn.Status.code(:ok)
    end

    test "updates the client", context do
      client2 = HonchoApi.Repo.get!(HonchoApi.Client, context.client.id)
      assert client2.name == "New Name"
    end

    test "renders the updated client", context do
      client2 = HonchoApi.Repo.get!(HonchoApi.Client, context.client.id)
      assert json_response(context.conn) == render_json(ClientsView, "show", %{client: client2})
    end
  end

  describe "PUT / when update fails" do
    setup context do
      client_params = %{name: ""}
      client = insert(:client, name: "Old Name")

      conn = put context.conn, "/api/clients/#{client.id}", client_params

      [client: client, client_params: client_params, conn: conn]
    end

    test "responds with 422 (unprocessable entity)", context do
      assert context.conn.status == Plug.Conn.Status.code(:unprocessable_entity)
    end

    test "does not update the client", context do
      client2 = HonchoApi.Repo.get!(HonchoApi.Client, context.client.id)
      assert client2.name == "Old Name"
    end

    test "renders an error", context do
      assert match?(%{"errors" => _}, json_response(context.conn))
    end
  end
end
