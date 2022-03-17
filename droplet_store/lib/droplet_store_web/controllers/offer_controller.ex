defmodule DropletStoreWeb.OfferController do
  use DropletStoreWeb, :controller

  alias DropletStore.Publishments
  alias DropletStore.Publishments.Offer

  def index(conn, _params) do
    offers = Publishments.list_offers()
    render(conn, "index.html", offers: offers)
  end

  def new(conn, _params) do
    changeset = Publishments.change_offer(%Offer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"offer" => offer_params}) do
    case Publishments.create_offer(offer_params) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, "Offer created successfully.")
        |> redirect(to: Routes.offer_path(conn, :show, offer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    offer = Publishments.get_offer!(id)
    render(conn, "show.html", offer: offer)
  end

  def edit(conn, %{"id" => id}) do
    offer = Publishments.get_offer!(id)
    changeset = Publishments.change_offer(offer)
    render(conn, "edit.html", offer: offer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "offer" => offer_params}) do
    offer = Publishments.get_offer!(id)

    case Publishments.update_offer(offer, offer_params) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, "Offer updated successfully.")
        |> redirect(to: Routes.offer_path(conn, :show, offer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", offer: offer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    offer = Publishments.get_offer!(id)
    {:ok, _offer} = Publishments.delete_offer(offer)

    conn
    |> put_flash(:info, "Offer deleted successfully.")
    |> redirect(to: Routes.offer_path(conn, :index))
  end
end
