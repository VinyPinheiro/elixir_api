defmodule GbsApiWeb.JobsController do
  use GbsApiWeb, :controller

  alias GbsApi.Store

  action_fallback GbsApiWeb.FallbackController

  def show(conn, %{"id" => id}) do
    job = Store.get_job!(id)
    json conn, job
  end
end
