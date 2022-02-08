defmodule DropletStoreWeb.PageControllerTest do
  use DropletStoreWeb.ConnCase

  @test_email "some_email"
  
  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert redirected_to(conn) == Routes.auth_path(conn, :login)
  end

  test "GET / logged in", %{conn: conn} do
    conn = conn
    |> Plug.Test.init_test_session(current_user: @test_email)
    |> get("/")
    assert html_response(conn, 200) =~ "Welcome to Droplet!"
  end
end
