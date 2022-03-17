defmodule DropletStoreWeb.OfferControllerTest do
  use DropletStoreWeb.ConnCase

  import DropletStore.PublishmentsFixtures

  @create_attrs %{currency: "EUR", description: "some description", price: "120.5", title: "some title"}
  @update_attrs %{description: "some updated description", price: "456.7", title: "some updated title"}
  @invalid_attrs %{currency: nil, description: nil, price: nil, title: nil}

  setup [:register_and_log_in_user, :create_store]
  
  describe "index" do
    test "lists all offers", %{conn: conn, store: store} do
      conn = get(conn, Routes.store_offer_path(conn, :index, store.id))
      assert html_response(conn, 200) =~ "Listing Offers"
    end
  end

  describe "new offer" do
    test "renders form", %{conn: conn, store: store} do
      conn = get(conn, Routes.store_offer_path(conn, :new, store.id))
      assert html_response(conn, 200) =~ "New Offer"
    end
  end

  describe "create offer" do
    test "redirects to show when data is valid", %{conn: conn, store: store} do
      conn = post(conn, Routes.store_offer_path(conn, :create, store.id), offer: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.store_offer_path(conn, :show, store.id, id)

      conn = get(conn, Routes.store_offer_path(conn, :show, store.id, id))
      assert html_response(conn, 200) =~ "Show Offer"
    end

    test "renders errors when data is invalid", %{conn: conn, store: store} do
      conn = post(conn, Routes.store_offer_path(conn, :create, store.id), offer: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Offer"
    end
  end

  describe "edit offer" do
    setup [:create_offer]

    test "renders form for editing chosen offer", %{conn: conn, store: store, offer: offer} do
      conn = get(conn, Routes.store_offer_path(conn, :edit, store.id, offer))
      assert html_response(conn, 200) =~ "Edit Offer"
    end
  end

  describe "update offer" do
    setup [:create_offer]

    test "redirects when data is valid", %{conn: conn, store: store, offer: offer} do
      conn = put(conn, Routes.store_offer_path(conn, :update, store.id, offer), offer: @update_attrs)
      assert redirected_to(conn) == Routes.store_offer_path(conn, :show, store.id, offer)

      conn = get(conn, Routes.store_offer_path(conn, :show, store.id, offer))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, store: store, offer: offer} do
      conn = put(conn, Routes.store_offer_path(conn, :update, store.id, offer), offer: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Offer"
    end
  end

  describe "delete offer" do
    setup [:create_offer]

    test "deletes chosen offer", %{conn: conn, store: store, offer: offer} do
      conn = delete(conn, Routes.store_offer_path(conn, :delete, store.id, offer))
      assert redirected_to(conn) == Routes.store_offer_path(conn, :index, store.id)

      assert_error_sent 404, fn ->
        get(conn, Routes.store_offer_path(conn, :show, store.id, offer))
      end
    end
  end

  defp create_store(%{conn: conn}) do
    store = DropletStore.SubscriptionsFixtures.store_fixture()
    %{conn: conn, store: store}
  end
  
  defp create_offer(_) do
    offer = offer_fixture()
    %{offer: offer}
  end
end
