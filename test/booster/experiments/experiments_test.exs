defmodule AB.ExperimentsTest do
  use AB.DataCase

  alias AB.Experiments

  describe "experiments" do
    alias AB.Experiments.Experiment

      @valid_options [
        %{value: "red", percentage: 33},
        %{value: "green", percentage: 33},
        %{value: "blue", percentage: 33}]

      @valid_attrs %{
        description: "some description",
        key: "some_key",
        options: @valid_options}

      @update_attrs %{
        description: "some updated description",
        key: "some_key",
        options: @valid_options}

      def experiment_fixture(attrs \\ %{}) do
        {:ok, experiment} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Experiments.create_experiment()
        Experiments.get_experiment!(experiment.id, [:options])
      end

      test "list_experiments/0 returns all experiments" do
        experiment = experiment_fixture()
        experiments = Experiments.list_experiments()
        ids = Enum.map(experiments, fn(e)-> e.id end)
        assert Enum.member?(ids, experiment.id)
      end

      test "get_experiment!/1 returns the experiment with given id" do
        experiment = experiment_fixture()
        result = Experiments.get_experiment!(experiment.id)
        assert result.id == experiment.id
      end

      test "create_experiment/1 with valid data creates a experiment" do
        assert {:ok, %Experiment{} = experiment} = Experiments.create_experiment(@valid_attrs)
        assert experiment.description == "some description"
        assert experiment.key == "some_key"
      end

      test "update_experiment/2 with valid data updates the experiment" do
        experiment = experiment_fixture()
        assert {:ok, %Experiment{} = experiment} = Experiments.update_experiment(experiment, @update_attrs)
        assert experiment.description == "some updated description"
      end

      test "delete_experiment/1 deletes the experiment" do
        experiment = experiment_fixture()
        assert {:ok, %Experiment{}} = Experiments.delete_experiment(experiment)
        assert_raise Ecto.NoResultsError, fn -> Experiments.get_experiment!(experiment.id) end
      end
  end
end
