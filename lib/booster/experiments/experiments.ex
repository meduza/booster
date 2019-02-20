defmodule AB.Experiments do
  @moduledoc """
  The Experiments context.
  """

  import Ecto.Query, warn: false
  alias AB.Repo

  alias AB.Experiments.Experiment

  @doc """
  Returns the list of experiments.

  ## Examples

      iex> list_experiments()
      [%Experiment{}, ...]

  """
  def list_experiments(preload \\ []) do
    query = from e in Experiment,
            preload: ^preload
    Repo.all(query)
  end

  @doc """
  Gets a single experiment.

  Raises `Ecto.NoResultsError` if the Experiment does not exist.

  ## Examples

      iex> get_experiment!(123)
      %Experiment{}

      iex> get_experiment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_experiment!(id, preload \\ []) do
    query = from u in Experiment,
            where: u.id == ^id,
            preload: ^preload,
            limit: 1
    Repo.one!(query)
  end

  @doc """
  Creates a experiment.

  ## Examples

      iex> create_experiment(%{field: value})
      {:ok, %Experiment{}}

      iex> create_experiment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_experiment(attrs \\ %{}) do
    %Experiment{}
    |> Experiment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a experiment.

  ## Examples

      iex> update_experiment(experiment, %{field: new_value})
      {:ok, %Experiment{}}

      iex> update_experiment(experiment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_experiment(%Experiment{} = experiment, attrs) do
    experiment
    |> Experiment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Experiment.

  ## Examples

      iex> delete_experiment(experiment)
      {:ok, %Experiment{}}

      iex> delete_experiment(experiment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_experiment(%Experiment{} = experiment) do
    Repo.delete(experiment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking experiment changes.

  ## Examples

      iex> change_experiment(experiment)
      %Ecto.Changeset{source: %Experiment{}}

  """
  def change_experiment(%Experiment{} = experiment) do
    Experiment.changeset(experiment, %{})
  end
end
