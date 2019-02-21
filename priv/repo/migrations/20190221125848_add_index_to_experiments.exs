defmodule AB.Repo.Migrations.AddIndexToExperiments do
  use Ecto.Migration

  def up do
    create unique_index(:experiments, [:key])
  end

  def down do
    drop index(:experiments, [:key])
  end

end
