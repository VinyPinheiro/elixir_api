defmodule GbsApi.Store do
  @moduledoc """
  The Store context.
  """

  import Ecto.Query, warn: false
  alias GbsApi.Repo

  alias GbsApi.Store.Film

  @doc """
  Returns the list of films.

  ## Examples

      iex> list_films()
      [%Film{}, ...]

  """
  def list_films do
    Repo.all(Film)
  end

  @doc """
  Gets a single film.

  Raises `Ecto.NoResultsError` if the Film does not exist.

  ## Examples

      iex> get_film!(123)
      %Film{}

      iex> get_film!(456)
      ** (Ecto.NoResultsError)

  """
  def get_film!(id), do: Repo.get!(Film, id)

  @doc """
  Gets a list of film with condition.

  ## Examples

      iex> search_film([title: "The Hateful Eights"])
      [%Film{}]

      iex> search_film([title: "The Hateful Eightsss"])
      []

  """
  def search_film(search_struct) do
    query = from(Film, where: ^search_struct)
    Repo.all(query)
  end

  @doc """
  Creates a film.

  ## Examples

      iex> create_film(%{field: value})
      {:ok, %Film{}}

      iex> create_film(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_film(attrs \\ %{}) do
    %Film{}
    |> Film.changeset(attrs)
    |> Repo.insert()
  end


    @doc """
    Create a film unless exists.

    ## Examples

        iex> create_film_unless_title_exist([title: "The Hateful Eights"])
        [%Film{}]

        iex> create_film(%{field: bad_value})
        %Ecto.Changeset{}

    """
  def create_film_unless_title_exist(attrs \\ %{}) do
    film = search_film([title: attrs[:title]])
    if Enum.count(film) != 0 do
      film
    else
      {:ok, new_film} = create_film(attrs)
      [new_film]
    end
  end

  @doc """
  Updates a film.

  ## Examples

      iex> update_film(film, %{field: new_value})
      {:ok, %Film{}}

      iex> update_film(film, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_film(%Film{} = film, attrs) do
    film
    |> Film.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a film.

  ## Examples

      iex> delete_film(film)
      {:ok, %Film{}}

      iex> delete_film(film)
      {:error, %Ecto.Changeset{}}

  """
  def delete_film(%Film{} = film) do
    Repo.delete(film)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking film changes.

  ## Examples

      iex> change_film(film)
      %Ecto.Changeset{data: %Film{}}

  """
  def change_film(%Film{} = film, attrs \\ %{}) do
    Film.changeset(film, attrs)
  end
end
