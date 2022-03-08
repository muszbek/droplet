defmodule DropletStoreWeb.PageController do
  use DropletStoreWeb, :controller

  def index(conn, _params) do
    owner = conn.assigns[:current_user]
    stores = DropletStore.Subscriptions.get_user_stores(owner.id)

    conn
    |> delete_session(:store_details)
    |> render("index.html", stores: stores)
  end
end
