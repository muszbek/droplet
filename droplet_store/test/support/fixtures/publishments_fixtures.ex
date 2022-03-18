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
    
    new_attrs = Enum.into(attrs, %{
          currency: "EUR",
          description: "some description",
          price: "120.50",
          title: "some title"
			  })
    
    {:ok, offer} = DropletStore.Publishments.create_offer(store.id, new_attrs)
    offer
  end
end
