defmodule WidgetMarketplace.Repo.User do
  @moduledoc """
  Ecto schema for users.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias WidgetMarketplace.Repo.Widget

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :first_name, :string, null: false
    field :last_name, :string, null: false
    field :email, :string, null: false
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string, null: false

    has_many :widgets, Widget

    timestamps()
  end

  @required_fields [:first_name, :last_name, :email]
  @optional_fields [:password, :password_confirmation]

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> put_change(:password_hash, "asdf")
  end
end
