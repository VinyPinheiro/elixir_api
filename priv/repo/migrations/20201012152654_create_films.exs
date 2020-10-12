defmodule GbsApi.Repo.Migrations.CreateFilms do
  use Ecto.Migration

  def change do
    create table(:films, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :genders, {:array, :string}
      add :year, :string
      add :poster, :string
      add :actors, {:array, :string}
      add :director, {:array, :string}

      timestamps()
    end

  end
end
