defmodule DropletStoreWeb.OfferController do
  use DropletStoreWeb, :controller

  alias DropletStore.Publishments
  alias DropletStore.Publishments.Offer

  def index(conn, %{"store_id" => store_id}) do
    offers = Publishments.list_offers()
    render(conn, "index.html", store_id: store_id, offers: offers)
  end

  def new(conn, %{"store_id" => store_id}) do
    changeset = Publishments.change_offer(%Offer{})
    render(conn, "new.html", store_id: store_id, changeset: changeset)
  end

  def create(conn, %{"store_id" => store_id, "offer" => offer_params}) do
    case Publishments.create_offer(store_id, offer_params) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, "Offer created successfully.")
        |> redirect(to: Routes.store_offer_path(conn, :show, store_id, offer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", store_id: store_id, changeset: changeset)
    end
  end

  def show(conn, %{"store_id" => store_id, "id" => id}) do
    offer = Publishments.get_offer!(id)
    render(conn, "show.html", store_id: store_id, offer: offer)
  end

  def edit(conn, %{"store_id" => store_id, "id" => id}) do
    offer = Publishments.get_offer!(id)
    changeset = Publishments.change_offer(offer)
    render(conn, "edit.html", store_id: store_id, offer: offer, changeset: changeset)
  end

  def update(conn, %{"store_id" => store_id, "id" => id, "offer" => offer_params}) do
    offer = Publishments.get_offer!(id)

    case Publishments.update_offer(offer, offer_params) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, "Offer updated successfully.")
        |> redirect(to: Routes.store_offer_path(conn, :show, store_id, offer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", store_id: store_id, offer: offer, changeset: changeset)
    end
  end

  def delete(conn, %{"store_id" => store_id, "id" => id}) do
    offer = Publishments.get_offer!(id)
    {:ok, _offer} = Publishments.delete_offer(offer)

    conn
    |> put_flash(:info, "Offer deleted successfully.")
    |> redirect(to: Routes.store_offer_path(conn, :index, store_id))
  end
end
