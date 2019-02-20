defmodule AB.Options.Option do
  use Ecto.Schema
  import Ecto.Changeset
  alias AB.Experiments.Experiment


  schema "options" do
    field :value, :string
    field :percentage, :integer
    belongs_to :experiment, Experiment
    timestamps()
  end

  @doc false
  # ADD experiment_id to validate_required
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:experiment_id, :value, :percentage])
    |> validate_required([:value, :percentage])
  end
end
