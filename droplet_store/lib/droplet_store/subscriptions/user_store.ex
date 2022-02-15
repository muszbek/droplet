defmodule DropletStore.Subscriptions.UserStore do
  use Ecto.Schema
  import Ecto.Changeset

  alias DropletStore.Accounts.User
  alias DropletStore.Subscriptions.Store

  @primary_key false
  schema "users_stores" do
    field :relation, :string,
      default: "owner"
    belongs_to :user, User, primary_key: true
    belongs_to :store, Store, primary_key: true
  end

  @doc false
  def changeset(user_store, attrs) do
    user_store
    |> cast(attrs, [:relation, :user_id, :store_id])
    |> validate_required([:relation, :user_id, :store_id])
    |> validate_inclusion(:relation, ["owner"],
      message: "Relation has to be one of the following: owner")
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:store_id)
    |> unique_constraint([:user_id, :store_id], name: :user_id_store_id_unique_index)
  end
end
