defmodule GbsApi.Repo do
  use Ecto.Repo,
    otp_app: :gbs_api,
    adapter: Ecto.Adapters.Postgres
end
