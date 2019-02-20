defmodule ABWeb.DeviceTokenPlugTest do
  use ABWeb.ConnCase
  import Plug.Conn

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "device-token", "s67dhdhs7")}
  end

  test "DeviceToken Plug assign device_token", %{conn: conn} do
    conn = get(conn, Routes.experiment_path(conn, :index))
    assert conn.assigns[:device_token] == "s67dhdhs7"
  end

end
