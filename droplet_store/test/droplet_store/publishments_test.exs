defmodule DropletStore.PublishmentsTest do
  use DropletStore.DataCase

  alias DropletStore.Publishments

  describe "offers" do
    alias DropletStore.Publishments.Offer

    import DropletStore.PublishmentsFixtures

    @invalid_attrs %{currency: nil, description: nil, price: nil, title: nil}

    test "list_offers/0 returns all offers" do
      offer = offer_fixture()
      assert Publishments.list_offers() == [offer]
    end

    test "get_offer!/1 returns the offer with given id" do
      offer = offer_fixture()
      assert Publishments.get_offer!(offer.id) == offer
    end

    test "create_offer/1 with valid data creates a offer" do
      store = DropletStore.SubscriptionsFixtures.store_fixture()
      valid_attrs = %{currency: "EUR", description: "some description", price: "120.5", title: "some title", store_id: store.id}

      assert {:ok, %Offer{} = offer} = Publishments.create_offer(valid_attrs)
      assert offer.currency == "EUR"
      assert offer.description == "some description"
      assert offer.price == Decimal.new("120.5")
      assert offer.title == "some title"
    end

    test "create_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Publishments.create_offer(@invalid_attrs)
    end

    test "update_offer/2 with valid data updates the offer" do
      offer = offer_fixture()
      update_attrs = %{description: "some updated description", price: "456.7", title: "some updated title"}

      assert {:ok, %Offer{} = offer} = Publishments.update_offer(offer, update_attrs)
      assert offer.description == "some updated description"
      assert offer.price == Decimal.new("456.7")
      assert offer.title == "some updated title"
    end

    test "update_offer/2 with invalid data returns error changeset" do
      offer = offer_fixture()
      assert {:error, %Ecto.Changeset{}} = Publishments.update_offer(offer, @invalid_attrs)
      assert offer == Publishments.get_offer!(offer.id)
    end

    test "delete_offer/1 deletes the offer" do
      offer = offer_fixture()
      assert {:ok, %Offer{}} = Publishments.delete_offer(offer)
      assert_raise Ecto.NoResultsError, fn -> Publishments.get_offer!(offer.id) end
    end

    test "change_offer/1 returns a offer changeset" do
      offer = offer_fixture()
      assert %Ecto.Changeset{} = Publishments.change_offer(offer)
    end
  end
end
