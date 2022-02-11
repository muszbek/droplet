defmodule DropletStoreWeb.PageController do
  use DropletStoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
