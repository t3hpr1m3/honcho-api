use Mix.Config

config :logger, level: :warn

config :honcho_api, HonchoApi.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: System.get_env("DB_USER") || "${DB_USER}",
  password: System.get_env("DB_PASSWORD") || "${DB_PASSWORD}",
  database: System.get_env("DB_NAME") || "${DB_NAME}",
  hostname: System.get_env("DB_HOST") || "${DB_HOST}",
  pool: Ecto.Adapters.SQL.Sandbox
