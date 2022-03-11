defmodule DropletStore.KafkaLib do

  @client_name :kafka_client

  def start_client() do
    :ok = :brod.start_client(hosts(), @client_name)
  end
  
  def hosts() do
    Application.get_env(:droplet_store, __MODULE__)[:hosts]
  end
end
