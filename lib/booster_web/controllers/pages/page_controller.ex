defmodule ABWeb.PageController do
  use ABWeb, :controller
  alias AB.Report

  def index(conn, _params) do
    reports = Report.get()
    render(conn, "index.html", reports: reports)
  end
end
