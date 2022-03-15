defmodule DropletStore.KafkaLib do

  alias DropletStore.Offers
  
  @client_name :kafka_client
  @num_partitions 1
  @replication_factor 1

  def start_client() do
    :ok = get_impl().start_client(hosts(), @client_name)
  end

  def create_topic(store_details) do
    topic = Offers.create_topic_name(store_details)

    topic_config = [
      %{
	configs: [],
	num_partitions: @num_partitions,
	assignments: [],
	replication_factor: @replication_factor,
	name: topic
      }
    ]

    case get_impl().create_topics(hosts(), topic_config, %{timeout: 1_000}) do
      :ok -> :ok
      {:error, :topic_already_exists} -> :ok
    end
  end

  def delete_topic(store_details) do
    topic = Offers.create_topic_name(store_details)
    case get_impl().delete_topics(hosts(), [topic], 1_000) do
      :ok -> :ok
      {:error, :unknown_topic_or_partition} -> :ok
    end
  end

  def start_producer(topic) when is_binary(topic) do
    :ok = get_impl().start_producer(@client_name, topic, _producer_config = [])
  end
  def start_producer(store_details) do
    topic = Offers.create_topic_name(store_details)
    start_producer(topic)
  end
  
  def produce(topic, key, payload) do
    :ok = get_impl().produce_sync(@client_name, topic, :hash, key, payload)
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
