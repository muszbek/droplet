defmodule DropletStoreWeb.AuthController do
  use DropletStoreWeb, :controller

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias DropletStore.Users
  require Logger

  def login(conn, _params) do
    render(conn, "login.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    Logger.warn(inspect(fails, pretty: true))
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    Logger.warn(inspect(auth, pretty: true))
    user = Users.email_from_auth(auth)
    
    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> put_session(:current_user, user)
    |> configure_session(renew: true)
    |> redirect(to: "/")
  end
  
end
