defmodule DropletStore.BrodMock do

  def start_client(_hosts, _client_name), do: :ok

  def create_topics(_hosts, _topic_config, _request_config), do: :ok

  def delete_topics(_hosts, _topic, _timeout), do: :ok

end
