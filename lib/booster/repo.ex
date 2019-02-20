defmodule AB.Repo do
  use Ecto.Repo,
    otp_app: :booster,
    adapter: Ecto.Adapters.Postgres
end
