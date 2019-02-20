defmodule AB.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :value, :string
      add :percentage, :integer
      add :experiment_id, references(:experiments)
      timestamps()
    end

  end
end
