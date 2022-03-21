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
      |> create_attrs()
      |> DropletStore.Subscriptions.create_store()

    store
  end

  def store_fixture_with_owner(owner, attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> create_attrs()
      |> DropletStore.Subscriptions.create_store_with_owner(owner)

    store
  end

  defp create_attrs(attrs) do
    attrs
    |> Enum.into(%{address: "some address",
		   google_id: "some google_id",
		   lat: "10.0",
		   lng: "-10.0"})
  end
end
