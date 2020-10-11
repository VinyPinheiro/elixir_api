defmodule GbsApiWeb.PageController do
  use GbsApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
