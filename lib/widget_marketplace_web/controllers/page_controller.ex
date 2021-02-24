defmodule WidgetMarketplaceWeb.PageController do
  use WidgetMarketplaceWeb, :controller

  alias WidgetMarketplace.Repo.Widget
  alias WidgetMarketplace.Guardian

  def index(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end

  def widgets(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    widgets = WidgetMarketplace.all(Widget)

    render(conn, "widgets.html", current_user: user, widgets: widgets)
  end
end
