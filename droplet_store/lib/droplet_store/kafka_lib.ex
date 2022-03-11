defmodule DropletStore.KafkaLib do

  @client_name :kafka_client

  def start_client() do
    :ok = get_impl().start_client(hosts(), @client_name)
  end
  
  defp hosts() do
    Application.get_env(:droplet_store, __MODULE__)[:hosts]
  end

  defp get_impl() do
    Application.get_env(:droplet_store, __MODULE__)[:impl]
  end
end
