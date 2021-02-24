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

  def new_widget(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    changeset_with_user = Widget.changeset(%Widget{}, %{user: user})

    render(conn, "new_widget.html",
      changeset: changeset_with_user,
      current_user: user,
      action:
        Routes.page_path(conn, :new_widget)
        |> IO.inspect(label: "=====================> action rout")
    )
  end

  def create_widget(conn, %{
        "widget" => %{"description" => description, "price" => price}
      }) do
    user = Guardian.Plug.current_resource(conn)

    Widget
    |> WidgetMarketplace.create(%{
      description: description,
      price: price,
      user: user
    })
    |> case do
      {:ok, _widget} ->
        conn
        |> put_flash(:info, "Widget created!")
        |> redirect(to: "/widgets")

      {:error, changeset} ->
        render(conn, "new_widget.html",
          changeset: changeset,
          action: Routes.page_path(conn, :new_widget)
        )
    end
  end
end
