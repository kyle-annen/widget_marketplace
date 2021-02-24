defmodule WidgetMarketplace.Repo.Migrations.AddTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :amount, :integer, null: false
      add :buyer_id, :uuid
      add :seller_id, :uuid, null: false
      add :widget_id, references("widgets", name: :id, type: :uuid)

      timestamps()
    end
  end
end
