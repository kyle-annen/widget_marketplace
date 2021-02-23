defmodule WidgetMarketplace.Repo.Widget do
  @moduledoc """
  Ecto schema for widgets.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias WidgetMarketplaUwerce.Repo.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "widgets" do
    field :description, :string, null: false
    field :price, :integer, null: false
    belongs_to :user, User

    timestamps()
  end

  @required_fields [:description, :price]
  @optional_fields []

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
