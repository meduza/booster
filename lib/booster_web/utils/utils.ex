defmodule ABWeb.Utils do
  use ABWeb, :controller

  def get_device_token(conn) do
    case conn.assigns[:device_token] do
        nil -> {:error, :device_token_not_found}
      token -> {:ok, token}
    end
  end

end
