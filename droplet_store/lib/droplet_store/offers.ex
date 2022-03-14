defmodule DropletStore.Offers do

  @api_version "v1"
  
  def create_payload(params) do
    %{
      uid: Ecto.UUID.generate(),
      type: "publish",
      title: params["title"],
      description: params["description"],
      price: params["price"],
      timestamp: DateTime.utc_now() |> to_string()
    }
    |> Jason.encode!()
  end

  def create_topic_name(store_details) do
    country = store_details.country
    loc = create_location(store_details.location)
    "stores_" <> @api_version <> "_offers_" <> country <> "_" <> loc
  end

  defp create_location(loc) do
    lat = loc["lat"] |> :erlang.float_to_binary(decimals: 7)
    lng = loc["lng"] |> :erlang.float_to_binary(decimals: 7)
    lat <> "-" <> lng
  end
  
end
