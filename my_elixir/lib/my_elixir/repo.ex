defmodule MyElixir.Repo do
  use Ecto.Repo,
    otp_app: :my_elixir,
    adapter: Ecto.Adapters.Postgres
end
