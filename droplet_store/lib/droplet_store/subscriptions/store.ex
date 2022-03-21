defmodule DropletStore.Subscriptions.Store do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stores" do
    field :address, :string
    field :google_id, :string
    field :location, Geo.PostGIS.Geometry

    many_to_many :users, DropletStore.Accounts.User,
      join_through: DropletStore.Subscriptions.UserStore
    has_many :offers, DropletStore.Publishments.Offer
    
    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:address, :google_id, :location])
    |> validate_required([:address, :google_id])
  end
end
