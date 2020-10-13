defmodule Events.FilmPublisher do
  def publish(message) do
    channel_name = "films"
    {:ok, connection} = AMQP.Connection.open(amqp_connection_string())
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, channel_name)

    AMQP.Basic.publish(channel, "", channel_name, message)
    IO.puts "Publicado #{message}"

    AMQP.Connection.close(connection)
  end

  defp amqp_connection_string do
    host = System.get_env("RABBITMQ_HOST")
    port = System.get_env("RABBITMQ_PORT")
    username = System.get_env("RABBITMQ_USER")
    password = System.get_env("RABBITMQ_PASSWORD")
    "amqp://#{username}:#{password}@#{host}:#{port}"
  end
end
