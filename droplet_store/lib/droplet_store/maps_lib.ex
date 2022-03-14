defmodule DropletStore.MapsLib do
  
  def place_details(google_id) do
    {:ok, %{"result" => store_from_google}} = get_impl().place_details(google_id)
    store_from_google
  end
  
  defp get_impl() do
    Application.get_env(:droplet_store, __MODULE__)[:impl]
  end
end
