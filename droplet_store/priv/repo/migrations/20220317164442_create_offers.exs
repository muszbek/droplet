defmodule DropletStore.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :title, :string, null: false
      add :description, :text
      add :price, :decimal, precision: 10, scale: 2, null: false
      add :currency, :string
      add :store_id, references(:stores, on_delete: :delete_all)

      timestamps()
    end

    create index(:offers, [:store_id])
  end
end
