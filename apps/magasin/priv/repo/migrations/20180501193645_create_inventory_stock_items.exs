defmodule Magasin.Repo.Migrations.CreateInventoryStockItems do
  use Ecto.Migration

  def change do
    create table(:magasin_inventory_stock_items, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:product_id, :binary_id, primary_key: true)
      add(:count_on_hand, :integer, null: false)

      timestamps()
    end
  end
end
