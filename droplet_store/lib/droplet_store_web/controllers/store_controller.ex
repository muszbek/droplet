defmodule DropletStoreWeb.StoreController do
  use DropletStoreWeb, :controller

  alias DropletStore.Subscriptions
  alias DropletStore.Subscriptions.Store
  alias DropletStore.MapsLib
  alias DropletStore.KafkaLib

  def index(conn, _params) do
    stores = Subscriptions.list_stores()

    conn
    |> delete_session(:store_details)
    |> render("index.html", stores: stores)
  end

  def new(conn, _params) do
    changeset = Subscriptions.change_store(%Store{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"store" => store_params}) do
    owner = conn.assigns[:current_user]
    
    case Subscriptions.create_store_with_owner(store_params, owner) do
      {:ok, store} ->
	store.google_id
	|> MapsLib.place_details()
	|> compress_store_details()
	|> KafkaLib.create_topic()
	
        conn
        |> put_flash(:info, "Store created successfully.")
        |> redirect(to: Routes.store_path(conn, :show, store))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    store = Subscriptions.get_store!(id)
    
    store_details = store.google_id
    |> MapsLib.place_details()
    |> compress_store_details()

    KafkaLib.start_producer(store_details)
    
    conn
    |> put_session(:store_details, store_details)
    |> render("show.html", store: store)
  end

  def edit(conn, %{"id" => id}) do
    store = Subscriptions.get_store!(id)
    changeset = Subscriptions.change_store(store)
    render(conn, "edit.html", store: store, changeset: changeset)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Subscriptions.get_store!(id)

    case Subscriptions.update_store(store, store_params) do
      {:ok, store} ->
        conn
        |> put_flash(:info, "Store updated successfully.")
        |> redirect(to: Routes.store_path(conn, :show, store))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", store: store, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    store = Subscriptions.get_store!(id)

    store.google_id
    |> MapsLib.place_details()
    |> compress_store_details()
    |> KafkaLib.delete_topic()
	
    {:ok, _store} = Subscriptions.delete_store(store)

    conn
    |> put_flash(:info, "Store deleted successfully.")
    |> redirect(to: Routes.store_path(conn, :index))
  end


  defp compress_store_details(store_data) do
    %{formatted_address: store_data["formatted_address"],
      formatted_phone_number: store_data["formatted_phone_number"],
      location: store_data["geometry"]["location"],
      country: get_country_code(store_data),
      icon: store_data["icon"],
      name: store_data["name"],
      opening_hours: store_data["opening_hours"]}
  end

  defp get_country_code(%{"address_components" => components} = _store_data) do
    do_get_country_code(components)
  end

  defp do_get_country_code([]), do: "unknown_country"
  defp do_get_country_code([%{"short_name" => short_name, "types" => types} | rest]) do
    if Enum.member?(types, "country") do
      short_name
    else
      do_get_country_code(rest)
    end
  end
end
