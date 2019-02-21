defmodule ABWeb.ReportController do
  use ABWeb, :controller
  alias AB.Report

  action_fallback ABWeb.FallbackController

  def index(conn, _params) do
    reports = Report.get()
    render(conn, "index.json", reports: reports)
  end

end
