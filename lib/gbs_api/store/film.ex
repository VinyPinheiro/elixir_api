defmodule GbsApi.Store.Film do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "films" do
    field :actors, {:array, :string}
    field :poster, :string
    field :director, {:array, :string}
    field :genders, {:array, :string}
    field :title, :string
    field :year, :string

    timestamps()
  end

  @doc false
  def changeset(film, attrs) do
    film
    |> cast(attrs, [:title, :genders, :year, :poster, :actors, :director])
    |> validate_required([:title, :genders, :poster, :actors, :director])
  end
end
