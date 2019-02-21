defmodule ABWeb.ExperimentController do
  use ABWeb, :controller

  alias AB.Experiments
  alias AB.Experiments.Experiment

  action_fallback ABWeb.FallbackController

  def index(conn, _params) do
    experiments = Experiments.list_experiments([:options])
    render(conn, "index.json", experiments: experiments)
  end

  def create(conn, %{"experiment" => experiment_params}) do
    with {:ok, %Experiment{} = experiment} <- Experiments.create_experiment(experiment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.experiment_path(conn, :show, experiment))
      |> render("show.json", experiment: experiment)
    end
  end

  def show(conn, %{"id" => id}) do
    experiment = Experiments.get_experiment!(id)
    render(conn, "show.json", experiment: experiment)
  end

  def update(conn, %{"id" => id, "experiment" => experiment_params}) do
    experiment = Experiments.get_experiment!(id)
    with {:ok, %Experiment{} = experiment} <- Experiments.update_experiment(experiment, experiment_params) do
      render(conn, "show.json", experiment: experiment)
    end
  end

  def delete(conn, %{"id" => id}) do
    experiment = Experiments.get_experiment!(id)
    with {:ok, %Experiment{}} <- Experiments.delete_experiment(experiment) do
      send_resp(conn, :no_content, "")
    end
  end

end
