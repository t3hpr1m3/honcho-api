defmodule HonchoApi.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :name
    field :address1
    field :address2
    field :city
    field :state
    field :zip

    timestamps(usec: false)
  end

  @fields ~w(name address1 address2 city state zip)a
  @required_fields ~w(name address1 city state zip)a

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
