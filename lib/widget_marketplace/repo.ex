defmodule WidgetMarketplace.Repo do
  use Ecto.Repo,
    otp_app: :widget_marketplace,
    adapter: Ecto.Adapters.Postgres
end
