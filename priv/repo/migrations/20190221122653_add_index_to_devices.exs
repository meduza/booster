defmodule AB.Repo.Migrations.AddIndexToDevices do
  use Ecto.Migration

  def up do
    create unique_index(:devices, [:token, :experiment_id])
  end

  def down do
    drop index(:devices, [:token, :experiment_id])
  end

end
