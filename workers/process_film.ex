defmodule Workers.ProcessFilm do
  use GenServer

  alias GbsApi.Store

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: :process_film)
  end

  def init(arg) do
    try do
      channel_name = "films"
      {:ok, connection} = AMQP.Connection.open(amqp_connection_string())
      {:ok, channel} = AMQP.Channel.open(connection)
      AMQP.Queue.declare(channel, channel_name)
      AMQP.Basic.consume(channel, channel_name, nil, no_ack: true)
      Agent.start_link(fn -> [] end, name: :batcher)
      _run()
    rescue _e in MatchError ->
      IO.puts "Fail to connect to AMQP!"
      init(arg)
    end
  end

  defp _run do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts "received a message! #{payload}"
        try do
          {:ok, data} = Poison.decode(payload)
          call(data)
          _run()
        rescue e in Error ->
          IO.puts "#{e}"
        end
    end
  end

  defp call(payload) do
    omdb_result = request_omdb(payload["title"])
    Store.create_film_unless_title_exist(de_para(omdb_result))
    Store.update_job_finish_task(payload["job_id"])
  end

  defp request_omdb(title) do
    token = System.get_env("OMDBAPI_TOKEN")
    url = "http://www.omdbapi.com/"

    parameters = [apikey: token, t: title]
    {:ok, response} = HTTPoison.get(url, [], params: parameters)
    parsed = Poison.decode!(response.body)
  end

  defp de_para(hash) do
    %{
      title: hash["Title"],
      year: hash["Year"],
      director:  String.split(hash["Director"], ", "),
      poster: hash["Poster"],
      genders: String.split(hash["Genre"], ", "),
      actors: String.split(hash["Actors"], ", ")
    }
  end

  defp amqp_connection_string do
    host = System.get_env("RABBITMQ_HOST")
    port = System.get_env("RABBITMQ_PORT")
    username = System.get_env("RABBITMQ_USER")
    password = System.get_env("RABBITMQ_PASSWORD")
    "amqp://#{username}:#{password}@#{host}:#{port}"
  end
end

Workers.ProcessFilm.start_link([])
