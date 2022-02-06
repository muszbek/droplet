defmodule DropletStore.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :address, :string, null: false
      add :google_id, :string, null: false

      timestamps()
    end
  end
end
