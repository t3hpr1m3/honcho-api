defmodule HonchoApi.Routes.ClientsTest do
  use HonchoApi.ConnCase
  alias HonchoApi.Views.ClientsView
  import HonchoApi.Factory

  test "/ renders a list of clients" do
    conn = build_conn()
    client = insert(:client)

    conn = get conn, "/api/clients/"

    assert json_response(conn, 200) == render_json(ClientsView, "index", %{clients: [client]})
  end

  test "/:id renders a single client" do
    conn = build_conn()
    client = insert(:client)

    conn = get conn, "/api/clients/#{client.id}"

    assert json_response(conn, 200) == render_json(ClientsView, "show", %{client: client})
  end
end
