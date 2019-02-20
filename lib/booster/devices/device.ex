defmodule AB.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset
  alias AB.Options.Option
  alias AB.Experiments.Experiment

  schema "devices" do
    field :token, :string
    belongs_to :option, Option
    belongs_to :experiment, Experiment
    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:token, :experiment_id, :option_id])
    |> validate_required([:token, :experiment_id, :option_id])
  end

end
