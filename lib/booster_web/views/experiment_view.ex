defmodule ABWeb.ExperimentView do
  use ABWeb, :view
  alias ABWeb.ExperimentView

  def render("index.json", %{experiments: experiments}) do
    %{data: render_many(experiments, ExperimentView, "experiment.json")}
  end

  def render("show.json", %{experiment: experiment}) do
    %{data: render_one(experiment, ExperimentView, "experiment.json")}
  end

  def render("experiment.json", %{experiment: experiment}) do
    %{id: experiment.id,
      description: experiment.description,
      key: experiment.key,
      options: render_many(experiment.options, ExperimentView, "option.json")
      }
  end

  def render("option.json", %{experiment: option}) do
    %{
      id: option.id,
      value: option.value
     }
  end
end
