defmodule WidgetMarketplaceWeb.PageController do
  use WidgetMarketplaceWeb, :controller

  alias WidgetMarketplace.Guardian
  alias WidgetMarketplace.Repo.Widget

  def index(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end

  def widgets(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    widgets = WidgetMarketplace.all(Widget, [:user])
    new_widget_path = Routes.page_path(conn, :new_widget)
    add_funds_path = Routes.page_path(conn, :add_funds)

    render(conn, "widgets.html",
      current_user: user,
      widgets: widgets,
      new_widget_path: new_widget_path,
      add_funds_path: add_funds_path
    )
  end

  def new_widget(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    changeset_with_user = Widget.changeset(%Widget{}, %{user: user})

    render(conn, "new_widget.html",
      changeset: changeset_with_user,
      current_user: user,
      action: Routes.page_path(conn, :new_widget)
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
      user_id: user.id
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

  def add_funds(conn, assigns) do
    user = Guardian.Plug.current_resource(conn)
    widgets = WidgetMarketplace.all(Widget, [:user])
    new_widget_path = Routes.page_path(conn, :new_widget)
    add_funds_path = Routes.page_path(conn, :add_funds)

    render(conn, "widgets.html",
      current_user: user,
      widgets: widgets,
      new_widget_path: new_widget_path,
      add_funds_path: add_funds_path
    )
  end
end
