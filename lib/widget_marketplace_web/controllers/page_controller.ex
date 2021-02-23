defmodule WidgetMarketplaceWeb.PageController do
  use WidgetMarketplaceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
