defmodule ABWeb.ExperimentControllerTest do
  use ABWeb.ConnCase

  alias AB.Experiments
  alias AB.Experiments.Experiment

  @create_attrs %{
  	description: "Button color AB test",
  	key: "button_color",
  	options: [
  	 	%{value: "#FF0000", percentage: 33},
  	 	%{value: "#00FF00", percentage: 33},
  	 	%{value: "#0000FF", percentage: 33}
  	 ]
  }

  @invalid_attrs %{
  	description: "Button color AB test",
  	key: nil,
  	options: [
  	 	%{value: "#FF0000", percentage: 33},
  	 	%{value: "#00FF00", percentage: 33},
  	 	%{value: "#0000FF", percentage: 33}
  	 ]
  }

  def fixture(:experiment) do
    {:ok, experiment} = Experiments.create_experiment(@create_attrs)
    experiment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all experiments", %{conn: conn} do
      conn = get(conn, Routes.experiment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create experiment" do
    test "renders experiment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.experiment_path(conn, :create), experiment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.experiment_path(conn, :create), experiment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete experiment" do
    setup [:create_experiment]

    test "deletes chosen experiment", %{conn: conn, experiment: experiment} do
      conn = delete(conn, Routes.experiment_path(conn, :delete, experiment))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get(conn, Routes.experiment_path(conn, :show, experiment))
      end
    end
  end

  defp create_experiment(_) do
    experiment = fixture(:experiment)
    {:ok, experiment: experiment}
  end
end
