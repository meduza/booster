defmodule ABWeb.Plugs.DeviceToken do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn |> assign(:device_token, get_device_token(conn))
  end

  defp get_device_token(conn) do
    conn
      |> get_req_header("device-token")
      |> List.first()
  end

end
