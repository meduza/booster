defmodule ABWeb.ReportView do
  use ABWeb, :view
  alias ABWeb.ReportView

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{
      experiment_id: report.id,
      key: report.key,
      total_devices: report.total_devices,
      options: report.options
     }
  end

end
