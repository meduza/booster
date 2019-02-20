defmodule ABWeb.PageController do
  use ABWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
