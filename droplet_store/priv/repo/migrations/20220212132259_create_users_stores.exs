defmodule DropletStore.Repo.Migrations.CreateUsersStores do
  use Ecto.Migration

  def change do
    execute("CREATE TYPE relation AS ENUM ('owner')")
    
    create table(:users_stores, primary_key: false) do
      add :relation, :relation,
	default: "owner"
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true, null: false
      add :store_id, references(:stores, on_delete: :delete_all), primary_key: true, null: false
    end

    create index(:users_stores, [:user_id])
    create index(:users_stores, [:store_id])

    create unique_index(:users_stores, [:user_id, :store_id], name: :user_id_store_id_unique_index)
  end
end
