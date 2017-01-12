defmodule HonchoApi.Client do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Queryable

  schema "clients" do
    field :name
    field :address1
    field :address2
    field :city
    field :state
    field :zip

    timestamps(usec: false)
  end

  @required_fields ~w(name address1 city state zip)a
  @optional_fields ~w(address2)

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:zip, ~r/\d{5}/)
  end
end
