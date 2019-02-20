defmodule AB.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :token, :string
      add :experiment_id, references(:experiments)
      add :option_id, references(:options)
      timestamps()
    end

  end
end
