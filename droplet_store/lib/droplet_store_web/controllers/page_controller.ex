defmodule DropletStoreWeb.PageController do
  use DropletStoreWeb, :controller

  def index(conn, _params) do
    case get_session(conn, :current_user) do
      nil -> redirect(conn, to: Routes.auth_path(conn, :login))
      user -> render(conn, "index.html", current_user: user)
    end
  end

end
