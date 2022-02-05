defmodule DropletStoreWeb.StoreController do
  use DropletStoreWeb, :controller

  alias DropletStore.Stores
  alias DropletStore.Stores.Store
  require Logger

  def index(conn, _params) do
    stores = Stores.list_stores()
    render(conn, "index.html", stores: stores)
  end

  def new(conn, _params) do
    render(conn, "new.html", google_api_source: google_api_source())
  end

  def create(conn, %{"store" => store_params}) do
    #case Stores.create_store(store_params) do
    #  {:ok, store} ->
    conn
    |> put_flash(:info, "Store created successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    store = Stores.get_store!(id)
    render(conn, "show.html", store: store)
  end

  def edit(conn, %{"id" => id}) do
    store = Stores.get_store!(id)
    changeset = Stores.change_store(store)
    render(conn, "edit.html", store: store, changeset: changeset)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Stores.get_store!(id)

    case Stores.update_store(store, store_params) do
      {:ok, store} ->
        conn
        |> put_flash(:info, "Store updated successfully.")
        |> redirect(to: Routes.store_path(conn, :show, store))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", store: store, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    store = Stores.get_store!(id)
    {:ok, _store} = Stores.delete_store(store)

    conn
    |> put_flash(:info, "Store deleted successfully.")
    |> redirect(to: Routes.store_path(conn, :index))
  end

  defp google_api_source() do
    "https://maps.googleapis.com/maps/api/js?key=" <>
      get_api_key() <>
      "&callback=initMap&libraries=places"
  end
  
  defp get_api_key() do
    Application.get_env(:droplet_store, :google_maps)[:api_key]
  end
end
