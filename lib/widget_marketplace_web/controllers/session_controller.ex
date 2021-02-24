defmodule WidgetMarketplaceWeb.SessionController do
  use WidgetMarketplaceWeb, :controller

  alias WidgetMarketplace.Guardian
  alias WidgetMarketplace.Repo.User

  def new(conn, _) do
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/protected")
    else
      changeset = User.changeset(%User{}, %{})
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def signup(conn, _) do
    changeset = User.changeset(%User{}, %{})
    render(conn, "create.html", changeset: changeset, action: Routes.session_path(conn, :signup))
  end

  def create(conn, %{"user" => user_attrs}) do
    case WidgetMarketplace.create(User, user_attrs) do
      {:ok, user} ->
        login_reply({:ok, user}, conn)

      {:error, changeset} ->
        render(conn, "create.html",
          changeset: changeset,
          action: Routes.session_path(conn, :signup)
        )
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    email
    |> WidgetMarketplace.authenticate(password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/widgets")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
