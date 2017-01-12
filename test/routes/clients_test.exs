defmodule HonchoApi.Routes.ClientsTest do
  use HonchoApi.ConnCase
  alias HonchoApi.Views.ClientsView
  import HonchoApi.Factory

  test "#index renders a list of clients" do
    conn = build_conn()
    client = insert(:client)

    conn = get conn, "/api/clients"

    assert json_response(conn, 200) == render_json(ClientsView, "index.json", %{clients: [client]})
  end
end
