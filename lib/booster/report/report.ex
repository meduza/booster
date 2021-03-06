defmodule AB.Report do
  @moduledoc """
  Statistic report module
  """
  import Ecto.Query, warn: false
  alias AB.Repo
  alias AB.Devices.Device
  alias AB.Options.Option
  alias AB.Experiments.Experiment

  @doc """
  Returns Experiments Statistic by Device

  Да, здесь есть костыль, запорс к БД не возвращает
  данные, в необходимом формате, приходится
  парсить колонку options, чтобы посчитать кол-во устройств по опциям.
  Уверен, что это можно сделать средствами БД, но еще вопрос, что будет быстрее.
  В запросе все данные получены, запрос лаконичный, понятный и быстрый...
  """
  def get() do
    query = from e in Experiment,
            join: d in Device,
            on: d.experiment_id == e.id,
            join: o in Option,
            on: o.id == d.option_id,
            group_by: [e.id],
            select: %{
                id: e.id,
                key: e.key,
                description: e.description,
                total_devices: count(d),
                options: fragment("array_agg(?)", o.value)
            }
    Repo.all(query) |> parse_options()
  end

  defp parse_options(data) do
    Enum.reduce(data, [], fn(d, acc)->
      List.insert_at(acc, 0, Map.merge(d, %{options: count_options(d)}))
    end)
  end

  defp count_options(data) do
    Enum.reduce(data.options, %{}, fn(x, acc) ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
  end


end
