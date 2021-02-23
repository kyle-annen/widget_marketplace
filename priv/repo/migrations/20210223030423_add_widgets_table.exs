defmodule WidgetMarketplace.Repo.Migrations.AddWidgetsTable do
  use Ecto.Migration

  def change do
    create table(:widgets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :description, :string, null: false
      add :price, :integer, null: false
      add :user_id, references("users", name: :id, type: :uuid)

      timestamps()
    end
  end
end
