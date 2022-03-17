defmodule DropletStore.Publishments.Offer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "offers" do
    field :currency, :string,
      defualt: "EUR"
    field :description, :string
    field :price, :decimal
    field :title, :string

    belongs_to :store, DropletStore.Subscriptions.Store

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [:store_id, :title, :description, :price, :currency])
    |> validate_required([:store_id, :title, :price])
    |> validate_inclusion(:currency, ["EUR"], message: "Currency not supported.")
    |> validate_number(:price, greater_than_or_equal_to: 0)
    |> foreign_key_constraint(:store_id)
  end
end
