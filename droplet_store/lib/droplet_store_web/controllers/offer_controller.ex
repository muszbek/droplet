defmodule DropletStoreWeb.OfferController do
  use DropletStoreWeb, :controller

  alias DropletStore.Offers
  alias DropletStore.KafkaLib
  
  def new(conn, %{"store_id" => store_id}) do
    render(conn, "new.html", store_id: store_id)
  end

  def create(conn, %{"store_id" => store_id} = params) do
    topic = conn
    |> get_session(:store_details)
    |> Offers.create_topic()

    payload = params
    |> Offers.create_payload()

    #:ok = :brod.start_producer(:kafka_client, topic, _prod_config = [])
    
    conn
    |> put_flash(:info, "Offer created successfully.")
    |> redirect(to: Routes.store_path(conn, :show, store_id))
  end

end
