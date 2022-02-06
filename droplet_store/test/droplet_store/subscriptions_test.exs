defmodule DropletStore.SubscriptionsTest do
  use DropletStore.DataCase

  alias DropletStore.Subscriptions

  describe "stores" do
    alias DropletStore.Subscriptions.Store

    import DropletStore.SubscriptionsFixtures

    @invalid_attrs %{address: nil, google_id: nil}

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert Subscriptions.list_stores() == [store]
    end

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert Subscriptions.get_store!(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      valid_attrs = %{address: "some address", google_id: "some google_id"}

      assert {:ok, %Store{} = store} = Subscriptions.create_store(valid_attrs)
      assert store.address == "some address"
      assert store.google_id == "some google_id"
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subscriptions.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      update_attrs = %{address: "some updated address", google_id: "some updated google_id"}

      assert {:ok, %Store{} = store} = Subscriptions.update_store(store, update_attrs)
      assert store.address == "some updated address"
      assert store.google_id == "some updated google_id"
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = Subscriptions.update_store(store, @invalid_attrs)
      assert store == Subscriptions.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = Subscriptions.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> Subscriptions.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = Subscriptions.change_store(store)
    end
  end
end
