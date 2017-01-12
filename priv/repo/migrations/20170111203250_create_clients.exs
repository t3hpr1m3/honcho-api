defmodule HonchoApi.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :address1, :string
      add :address2, :string
      add :city, :string
      add :state, :string
      add :zip, :string

      timestamps
    end
  end
end
