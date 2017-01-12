defmodule HonchoApi.Client do
  use Ecto.Schema

  schema "clients" do
    field :name
    field :address1
    field :address2
    field :city
    field :state
    field :zip

    timestamps(usec: false)
  end
end
