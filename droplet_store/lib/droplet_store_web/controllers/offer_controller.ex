defmodule DropletStoreWeb.OfferController do
  use DropletStoreWeb, :controller

  require Logger
  
  def new(conn, %{"store_id" => store_id}) do
    render(conn, "new.html", store_id: store_id)
  end

  def create(conn, %{"store_id" => store_id} = params) do
    Logger.warn(inspect(params, pretty: true))
    
    conn
    |> put_flash(:info, "Offer created successfully.")
    |> redirect(to: Routes.store_path(conn, :show, store_id))
  end
end
