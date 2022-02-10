defmodule DropletStoreWeb.StoreView do
  use DropletStoreWeb, :view
  
  def google_api_source() do
    "https://maps.googleapis.com/maps/api/js?key=" <>
      get_api_key() <>
      "&callback=initMap&libraries=places"
  end
  
  defp get_api_key() do
    Application.get_env(:droplet_store, :google_maps)[:api_key]
  end
end
