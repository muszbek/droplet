defmodule DropletStoreWeb.PageController do
  use DropletStoreWeb, :controller

  def index(conn, _params) do
    owner = conn.assigns[:current_user]
    stores = DropletStore.Subscriptions.get_user_stores(owner.id)
    render(conn, "index.html", stores: stores)
  end
end
