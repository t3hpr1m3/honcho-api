defmodule HonchoApi.Views.ClientsView do
  use HonchoApi.View

  def render("index", %{clients: clients}) do
    %{clients: Enum.map(clients, &client_json/1)}
  end

  def render("show", %{client: client}) do
    %{client: client_json(client)}
  end

  def client_json(client) do
    %{
      name: client.name,
      address1: client.address1,
      city: client.city,
      state: client.state,
      zip: client.zip,
      inserted_at: NaiveDateTime.to_iso8601(client.inserted_at),
      updated_at: NaiveDateTime.to_iso8601(client.updated_at)
    }
  end
end
