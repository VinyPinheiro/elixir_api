FROM elixir:latest as worker

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /opt/app
WORKDIR /opt/app

# Install hex package manager
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.5.5 --force
RUN mix local.rebar --force

RUN mix do compile
CMD mix ecto.create && iex -S mix phx.server
