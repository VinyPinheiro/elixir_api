FROM elixir:latest

# install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /opt/app
WORKDIR /opt/app

# Install hex package manager
RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.5.5 --force
RUN mix local.rebar --force

# Compile assets
RUN cd assets && npm install

# Compile the project
RUN mix do compile

CMD iex -S mix phx.server
