defmodule ABWeb.PageControllerTest do
  use ABWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Booster report"
  end
end
