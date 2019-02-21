defmodule AB.Options.Dispatcher do
  @moduledoc """
  Device options dispatcher module
  """
  alias AB.Experiments
  alias AB.Devices.Device

  @doc """
  Get all experiments and select one option by percentage for device
  Return [%AB.Devices.Device{}]
  """
  def get do
    Experiments.list_experiments([:options])
    |> get_device_options()
    |> Enum.map(&(Map.take(&1, [:experiment_id, :option_id])))
  end


  defp get_device_options(experiments) do
    Enum.map(experiments, fn(experiment)->
      %Device{experiment_id: experiment.id,
        option_id: get_option_id(experiment.options)}
    end)
  end


  # Accepts List of experiment options
  # and returns one by percentage variation
  defp get_option_id(options) do
    Enum.reduce(options, [], fn(option, acc)->
      acc ++ List.duplicate(option.id, option.percentage)
    end) |> Enum.random()
  end

end
