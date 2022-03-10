defmodule DropletStoreWeb.OfferController do
  use DropletStoreWeb, :controller

  @api_version "v1"
  
  def new(conn, %{"store_id" => store_id}) do
    render(conn, "new.html", store_id: store_id)
  end

  def create(conn, %{"store_id" => store_id} = params) do
    topic = conn
    |> get_session(:store_details)
    |> create_topic()

    payload = params
    |> create_payload()

    :ok = KafkaEx.produce(topic, 0, payload)
    
    conn
    |> put_flash(:info, "Offer created successfully.")
    |> redirect(to: Routes.store_path(conn, :show, store_id))
  end

  defp create_payload(params) do
    %{
      uid: Ecto.UUID.generate(),
      type: "publish",
      title: params["title"],
      description: params["description"],
      price: params["price"]
    }
    |> Jason.encode!()
  end

  defp create_topic(store_details) do
    country = store_details.country
    loc = create_location(store_details.location)
    "stores/" <> @api_version <> "/offers/" <> country <> "/" <> loc
  end

  defp create_location(loc) do
    lat = loc["lat"] |> Float.to_string(decimals: 7)
    lng = loc["lng"] |> Float.to_string(decimals: 7)
    lat <> "&" <> lng
  end
end
