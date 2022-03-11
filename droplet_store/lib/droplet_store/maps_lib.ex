defmodule DropletStore.MapsLib do

  def place_details(google_id) do
    get_impl().place_details(google_id)
  end
  
  defp get_impl() do
    Application.get_env(:droplet_store, __MODULE__)[:impl]
  end
end
