defmodule DropletStore.Subscriptions do
  @moduledoc """
  The Subscriptions context.
  """

  import Ecto.Query, warn: false
  alias DropletStore.Repo

  alias DropletStore.Subscriptions.{Store, UserStore}

  @doc """
  Returns the list of stores.

  ## Examples

      iex> list_stores()
      [%Store{}, ...]

  """
  def list_stores do
    Repo.all(Store)
  end

  @doc """
  Gets a single store.

  Raises `Ecto.NoResultsError` if the Store does not exist.

  ## Examples

      iex> get_store!(123)
      %Store{}

      iex> get_store!(456)
      ** (Ecto.NoResultsError)

  """
  def get_store!(id), do: Repo.get!(Store, id)

  def get_store_owner(id) do
    user_store = UserStore
    |> where(store_id: ^id)
    |> where(relation: "owner")
    |> Repo.one!()

    DropletStore.Accounts.get_user!(user_store.user_id)
  end

  def get_user_stores(id) do
    DropletStore.Accounts.User
    |> where(id: ^id)
    |> preload(:stores)
    |> Repo.one!()
    |> Map.get(:stores)
  end

  @doc """
  Creates a store.

  ## Examples

      iex> create_store(%{field: value})
      {:ok, %Store{}}

      iex> create_store(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_store(attrs \\ %{}) do
    attrs = Morphix.atomorphify!(attrs)
    
    lat = String.to_float(attrs.lat)
    lng = String.to_float(attrs.lng)
    loc = %Geo.Point{coordinates: {lat, lng}}
    
    attrs_with_loc = Map.put(attrs, :location, loc)
    
    %Store{}
    |> Store.changeset(attrs_with_loc)
    |> Repo.insert()
  end

  def create_store_with_owner(attrs, owner) do
    case create_store(attrs) do
      {:ok, %Store{} = store} ->
	user_store_attrs = %{store_id: store.id, user_id: owner.id}
	
	%DropletStore.Subscriptions.UserStore{}
	|> DropletStore.Subscriptions.UserStore.changeset(user_store_attrs)
	|> Repo.insert()
	
	{:ok, store}
      error -> error
    end
  end

  @doc """
  Updates a store.

  ## Examples

      iex> update_store(store, %{field: new_value})
      {:ok, %Store{}}

      iex> update_store(store, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_store(%Store{} = store, attrs) do
    store
    |> Store.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a store.

  ## Examples

      iex> delete_store(store)
      {:ok, %Store{}}

      iex> delete_store(store)
      {:error, %Ecto.Changeset{}}

  """
  def delete_store(%Store{} = store) do
    Repo.delete(store)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking store changes.

  ## Examples

      iex> change_store(store)
      %Ecto.Changeset{data: %Store{}}

  """
  def change_store(%Store{} = store, attrs \\ %{}) do
    Store.changeset(store, attrs)
  end
end
