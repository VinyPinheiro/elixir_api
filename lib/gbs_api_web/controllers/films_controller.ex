defmodule GbsApiWeb.FilmsController do
  use GbsApiWeb, :controller

  alias GbsApi.Store

  action_fallback GbsApiWeb.FallbackController
  def create(conn, %{"_json" => params}) do

    job = create_job(Enum.count(params))
    publish_messages(params, job.id)

    json conn, job
  end

  def index(conn, _params) do
    films = Store.list_films()
    json conn, films
  end

  defp create_job(total) do
    attr = %{
      total: total,
      processed: 0
    }
    {:ok, job} = Store.create_job(attr)
    job
  end

  defp publish_messages(request_body, job_id) do
    for item <- request_body do
      message = %{
        title: item["title"],
        job_id: job_id
      }
      {:ok, msg_sender } = Poison.encode(message)

      Events.FilmPublisher.publish(msg_sender)
    end
  end
end
