defmodule DropletStore.KafkaLib do

  alias DropletStore.Offers
  
  @client_name :kafka_client
  @num_partitions 1
  @replication_factor 1

  def start_client() do
    :ok = get_impl().start_client(hosts(), @client_name)
  end

  def create_topic(store_details) do
    topic = Offers.create_topic(store_details)

    topic_config = [
      %{
	config_entries: [],
	num_partitions: @num_partitions,
	replica_assignment: [],
	replication_factor: @replication_factor,
	topic: topic
      }
    ]

    :ok = get_impl().create_topics(hosts(), topic_config, %{timeout: 1_000})
  end

  def get_metadata() do
    :brod.get_metadata(hosts())
  end

  def get_metadata(topic) do
    :brod.get_metadata(hosts(), [topic])
  end
  
  defp hosts() do
    Application.get_env(:droplet_store, __MODULE__)[:hosts]
  end

  defp get_impl() do
    Application.get_env(:droplet_store, __MODULE__)[:impl]
  end
end
