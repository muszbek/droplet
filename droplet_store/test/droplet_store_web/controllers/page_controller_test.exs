defmodule DropletStoreWeb.PageControllerTest do
  use DropletStoreWeb.ConnCase

  describe "logged in" do
    setup :register_and_log_in_user
    
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Welcome to Droplet!"
    end
  end
  
  describe "logged out" do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end

  
end
