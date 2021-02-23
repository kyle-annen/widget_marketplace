# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :widget_marketplace,
  ecto_repos: [WidgetMarketplace.Repo]

config :widget_marketplace, WidgetMarketplaceWeb.Guardian,
  issuer: "widget_marketplace",
  # this should be abstracted to an env variable which is set during prod docker build
  secret_key: "hbV7ionQAGK6QViWzthSX6aMuB49y5uWHR2PzYiWHbh1Bs7Q8U84CulM1xtuGgGv"

config :widget_marketplace, WidgetMarketplaceWeb.Endpoint,
  url: [host: "localhost"],
  # this should be abstracted to an env variable which is set during prod docker build
  secret_key_base: "0gQE2/c1LHOYfMpwna+2qoUqoqNrFCcZmlhDNSFmZ6Qkwbgy5aWD3GaIiw6qX9q/",
  render_errors: [view: WidgetMarketplaceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WidgetMarketplace.PubSub,
  live_view: [signing_salt: "X/TygAlQ"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
