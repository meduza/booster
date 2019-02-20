defmodule AB.OptionsTest do
  use AB.DataCase

  alias AB.Options
  alias AB.Experiments

  describe "options" do
    alias AB.Options.Option

    @valid_option %{value: "red", percentage: 33}
    @valid_update_option %{value: "red_updated", percentage: 33}

    @valid_options [
      %{value: "red", percentage: 33},
      %{value: "green", percentage: 33},
      %{value: "blue", percentage: 33}]

    @valid_attrs %{
      description: "some description",
      key: "some_key",
      options: @valid_options}


    def options_fixture(attrs \\ %{}) do
      {:ok, experiment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Experiments.create_experiment()
      Experiments.get_experiment!(experiment.id, [:options]).options
    end

    test "list_options/0 returns all options" do
      options = options_fixture()
      list = Options.list_options()
      assert length(options) == length(list)
    end

    test "get_option!/1 returns the option with given id" do
      option = options_fixture() |> List.first()
      result = Options.get_option!(option.id)
      assert result.id == option.id
    end

    test "create_option/1 with valid data creates a experiment" do
      option = options_fixture() |> List.first()
      assert {:ok, %Option{} = option} = Options.create_option(
        Map.merge(@valid_option, %{experiment_id: option.experiment_id}))
      assert option.percentage == 33
      assert option.value == "red"
    end

    test "update_option/2 with valid data updates the option" do
      option = options_fixture() |> List.first()
      assert {:ok, %Option{} = option} = Options.update_option(option,@valid_update_option)
      assert option.value == "red_updated"
    end

  end
end
