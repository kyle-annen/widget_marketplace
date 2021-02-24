defmodule WidgetMarketplace do
  @moduledoc """
  WidgetMarketplace encapsulating the backend business logic
  """
  import Ecto.Query, only: [from: 2]

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User

  @doc """
  Given a Repo schema namespace and id, returns schema struct
  """
  def get(schema, id), do: Repo.get(schema, id)

  @doc """
  Given a Repo schema namespace, returns all schema structs
  """
  def all(schema), do: Repo.all(schema)

  @doc """
  Given a Repo schema namespace and attributes, creates the schema entry
  """
  def create(schema, attrs) do
    schema.__struct__
    |> schema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Hashed the the password entered by the user, authenticates by compariing the
  password_hash against the hash produced from the user entered password during
  login.

  Note: User of Argon2.no_user_verify() below
  Ensures hash is run, making both successful/unsuccessful login attempts
  execute in the same time, this prevents harvesting of email addresses that
  exist in the system. If the emails in the system get harvested, rainbow and
  brute force attacks are more effective.
  """
  def authenticate(email, plaintext_password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        # In order to execute branching logic in similar time. See note above
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
