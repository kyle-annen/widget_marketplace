defmodule WidgetMarketplace.Repo.Widget do
  @moduledoc """
  Ecto schema for widgets.
  """
  use Ecto.Schema

  alias WidgetMarketplace.Repo.User

  schema "widgets" do
    field :description, :string, null: false
    field :price, 
    belongs_to :user, User

    timestamps()
  end

  @required_fields [:]
end
