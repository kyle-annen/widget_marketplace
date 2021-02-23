defmodule WidgetMarketplace do
  @moduledoc """
  WidgetMarketplace encapsulating the backend business logic
  """
  import Ecto.Query, only: [from: 2]

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User

  def get(schema, id) do
    Repo.get(schema, id)
  end

  def create(schema, attrs) do
    schema.__struct__
    |> schema.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate(email, plaintext_password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plaintext_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
