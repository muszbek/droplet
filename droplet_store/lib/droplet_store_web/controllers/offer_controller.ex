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
    |> Offers.create_topic_name()

    {key, payload} = Offers.create_payload(params)

    KafkaLib.produce(topic, key, payload)
    
    conn
    |> put_flash(:info, "Offer created successfully.")
    |> redirect(to: Routes.store_path(conn, :show, store_id))
  end

end
