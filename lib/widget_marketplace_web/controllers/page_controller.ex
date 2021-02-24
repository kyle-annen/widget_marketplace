defmodule WidgetMarketplaceWeb.PageController do
  use WidgetMarketplaceWeb, :controller

  def index(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end

  def market(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end
end
