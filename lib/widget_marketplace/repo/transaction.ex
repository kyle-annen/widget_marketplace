defmodule WidgetMarketplace.Repo.Transaction do
  @moduledoc """
  Ecto schema for widgets.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias WidgetMarketplace.Repo.Widget

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "transactions" do
    field :buyer_id, :binary_id
    field :seller_id, :binary_id, null: false
    field :amount, :integer, null: false
    belongs_to :widget, Widget

    timestamps()
  end

  @required_fields [:seller_id, :amount]
  @optional_fields [:buyer_id, :widget_id]

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
