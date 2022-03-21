defmodule DropletStore.Repo.Migrations.AddLocationToStores do
  use Ecto.Migration

  def change do
    alter table(:stores) do
      add :location, :geometry
    end

    create index(:stores, [:location])
  end
  
end
