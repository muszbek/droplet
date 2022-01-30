defmodule DropletStoreWeb.StoreController do
  use DropletStoreWeb, :controller

  alias DropletStore.Stores
  alias DropletStore.Stores.Store

  def index(conn, _params) do
    stores = Stores.list_stores()
    render(conn, "index.html", stores: stores)
  end

  def new(conn, _params) do
    render(conn, "new.html")
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
end
