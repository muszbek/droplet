defmodule DropletStore.Repo do
  import CouchDBEx

  def get_process() do
    {CouchDBEx.Worker, get_config()}
  end

  defp get_config() do
    Application.get_env(:droplet_store, CouchDBEx)
  end
end
