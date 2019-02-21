defmodule ABWeb.DeviceController do
  use ABWeb, :controller
  alias ABWeb.Utils
  alias AB.Devices

  action_fallback ABWeb.FallbackController

  def index(conn, _params) do
    with {:ok, token} <- Utils.get_device_token(conn),
       {:ok, devices} <- Devices.find_or_register_device(token) do
        render(conn, "index.json", devices: devices)
    end
  end

end
