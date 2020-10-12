# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GbsApi.Repo.insert!(%GbsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

GbsApi.Store.create_film(
  %{
    title: "Guardians of the Galaxy",
    year: "2014",
    director: ["James Gunn"],
    poster: "https://m.media-amazon.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_SX300.jpg",
    genders: ["Action", "Adventure", "Comedy", "Sci-Fi"],
    actors: ["Chris Pratt", "Zoe Saldana", "Dave Bautista", "Vin Diesel"]
    }
)
