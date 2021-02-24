defmodule WidgetMarketplaceWeb.PageController do
  use WidgetMarketplaceWeb, :controller

  alias WidgetMarketplace.Guardian
  alias WidgetMarketplace.Repo.Transaction
  alias WidgetMarketplace.Repo.User
  alias WidgetMarketplace.Repo.Widget

  @insufficient_funds_error "Insufficient funds, please add funds or sell a widget to increase account balance."

  def index(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end

  def widgets(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    user_balance = WidgetMarketplace.get_user_balance(user)
    widgets = WidgetMarketplace.all(Widget, [:user])
    new_widget_path = Routes.page_path(conn, :new_widget)
    add_funds_path = Routes.page_path(conn, :add_funds)

    transaction_changeset = Transaction.changeset(%Transaction{}, %{})

    render(conn, "widgets.html",
      current_user: user,
      user_balance: user_balance,
      transaction_changeset: transaction_changeset,
      transaction_action: Routes.page_path(conn, :buy_widget),
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

  def add_funds(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    user_balance = WidgetMarketplace.get_user_balance(user)
    widgets = WidgetMarketplace.all(Widget, [:user])
    new_widget_path = Routes.page_path(conn, :new_widget)
    add_funds_path = Routes.page_path(conn, :add_funds)

    {:ok, _transaction} =
      WidgetMarketplace.create(Transaction, %{
        seller_id: user.id,
        amount: 1000
      })

    reloaded_user = WidgetMarketplace.get(User, user.id)

    render(conn, "widgets.html",
      current_user: reloaded_user,
      user_balance: user_balance,
      widgets: widgets,
      new_widget_path: new_widget_path,
      add_funds_path: add_funds_path
    )
  end

  def buy_widget(conn, %{
        "transaction" => %{
          "amount" => amount,
          "seller_id" => seller_id,
          "widget_id" => widget_id
        }
      }) do
    buyer = Guardian.Plug.current_resource(conn)

    case WidgetMarketplace.purchase_widget(buyer, seller_id, widget_id, amount) do
      {:ok, _transaction} ->
        redirect(conn, to: "/widgets")

      {:error, _reason} ->
        conn
        |> put_flash(:error, @insufficient_funds_error)
        |> redirect(to: "/widgets")
    end
  end
end
