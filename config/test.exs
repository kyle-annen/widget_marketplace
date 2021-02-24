use Mix.Config

config :widget_marketplace, WidgetMarketplace.Repo,
  username: "postgres",
  password: "postgres",
  database: "widget_marketplace_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :widget_marketplace, WidgetMarketplaceWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
