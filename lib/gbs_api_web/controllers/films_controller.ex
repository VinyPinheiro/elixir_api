defmodule GbsApiWeb.FilmsController do
  use GbsApiWeb, :controller

  alias GbsApi.Api
  alias GbsApi.Api.Film

  action_fallback GbsApiWeb.FallbackController
  def create(conn, %{"_json" => params}) do
    first_title = List.first(params)["title"]
    token = ""
    url = "http://www.omdbapi.com/"

    lista = for item <- params do
      parameters = [apikey: token, t: item["title"]]
      {:ok, response} = HTTPoison.get(url, [], params: parameters)

      parsed = Poison.decode!(response.body)

      GbsApi.Store.create_film_unless_title_exist(de_para(parsed))
      de_para(parsed)
    end
    json conn, lista
  end

  def de_para(hash) do
    %{
      title: hash["Title"],
      year: hash["Year"],
      director:  String.split(hash["Director"], ", "),
      poster: hash["Poster"],
      genders: String.split(hash["Genre"], ", "),
      actors: String.split(hash["Actors"], ", ")
    }
  end
end
