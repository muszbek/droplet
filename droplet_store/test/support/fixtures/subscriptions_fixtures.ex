defmodule DropletStore.SubscriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DropletStore.Subscriptions` context.
  """

  @doc """
  Generate a store.
  """
  def store_fixture(attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> Enum.into(%{
        address: "some address",
        google_id: "some google_id"
      })
      |> DropletStore.Subscriptions.create_store()

    store
  end
end
