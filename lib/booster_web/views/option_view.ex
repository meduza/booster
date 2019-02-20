defmodule ABWeb.OptionView do
  use ABWeb, :view
  alias ABWeb.OptionView

  def render("index.json", %{options: options}) do
    %{data: render_many(options, OptionView, "option.json")}
  end

  def render("show.json", %{option: option}) do
    %{data: render_one(option, OptionView, "option.json")}
  end

  def render("option.json", %{option: option}) do
    %{id: option.id,
      experiment_id: option.experiment_id,
      key: option.key,
      value: option.value,
      percentage: option.percentage}
  end
end
