defmodule DropletStore.PublishmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DropletStore.Publishments` context.
  """

  @doc """
  Generate a offer.
  """
  def offer_fixture(attrs \\ %{}) do
    store = DropletStore.SubscriptionsFixtures.store_fixture()
    
    {:ok, offer} =
      attrs
      |> Enum.into(%{
        currency: "EUR",
        description: "some description",
        price: "120.50",
        title: "some title",
	store_id: store.id
      })
      |> DropletStore.Publishments.create_offer()

    offer
  end
end
