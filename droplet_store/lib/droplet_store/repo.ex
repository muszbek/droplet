defmodule DropletStore.Repo do
  use Ecto.Repo,
    otp_app: :droplet_store,
    adapter: Ecto.Adapters.Postgres
end
