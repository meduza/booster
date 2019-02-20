defmodule AB.Repo.Migrations.CreateExperiments do
  use Ecto.Migration

  def change do
    create table(:experiments) do
      add :description, :string
      add :key, :string

      timestamps()
    end

  end
end
