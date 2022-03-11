defmodule DropletStore.Offers do

  @api_version "v1"
  
  def create_payload(params) do
    %{
      uid: Ecto.UUID.generate(),
      type: "publish",
      title: params["title"],
      description: params["description"],
      price: params["price"]
    }
    |> Jason.encode!()
  end

  def create_topic(store_details) do
    country = store_details.country
    loc = create_location(store_details.location)
    "stores/" <> @api_version <> "/offers/" <> country <> "/" <> loc
  end

  defp create_location(loc) do
    lat = loc["lat"] |> :erlang.float_to_binary(decimals: 7)
    lng = loc["lng"] |> :erlang.float_to_binary(decimals: 7)
    lat <> "&" <> lng
  end
  
end