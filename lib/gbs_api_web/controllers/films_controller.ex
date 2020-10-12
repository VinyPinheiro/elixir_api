defmodule GbsApiWeb.FilmsController do
  use GbsApiWeb, :controller

  alias GbsApi.Store

  action_fallback GbsApiWeb.FallbackController
  def create(conn, %{"_json" => params}) do
    publish_messages(params)

    job = create_job(Enum.count(params))
    json conn, job
  end

  def create_job(total) do
    attr = %{
      total: total,
      processed: 0
    }
    {:ok, job} = Store.create_job(attr)
    job
  end

  def publish_messages(request_body) do
    token = "373cf7e2"
    url = "http://www.omdbapi.com/"

    lista = for item <- request_body do
      parameters = [apikey: token, t: item["title"]]
      {:ok, response} = HTTPoison.get(url, [], params: parameters)

      parsed = Poison.decode!(response.body)

      Store.create_film_unless_title_exist(de_para(parsed))
      de_para(parsed)
    end
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
