defmodule GbsApi.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :total, :integer
      add :processed, :integer

      timestamps()
    end

  end
end
