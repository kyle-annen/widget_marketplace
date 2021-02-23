defmodule WidgetMarketplace.Repo.User do
  @moduledoc """
  Ecto schema for users.
  """
  use Ecto.Schema

  alias WidgetMarketplace.Repo.Widget

  schema "users" do
    field :name, :string, null: false
    field :email, :string, null: false
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string, null: false

    has_many :widgets, Widget

    timestamps()
  end
end
