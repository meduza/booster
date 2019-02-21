defmodule AB.Experiments.Experiment do
  use Ecto.Schema
  import Ecto.Changeset
  alias AB.Options.Option


  schema "experiments" do
    field :description, :string
    field :key, :string
    has_many :options, Option, on_replace: :nilify, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(experiment, attrs) do
    experiment
    |> cast(attrs, [:key, :description])
    |> cast_assoc(:options)
    |> validate_required([:key, :description, :options])
    |> unique_constraint(:key, name: :experiments_key_index)
  end
end
