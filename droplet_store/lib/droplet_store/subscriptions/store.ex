defmodule DropletStore.Subscriptions.Store do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stores" do
    field :address, :string
    field :google_id, :string

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:address, :google_id])
    |> validate_required([:address, :google_id])
  end
end
