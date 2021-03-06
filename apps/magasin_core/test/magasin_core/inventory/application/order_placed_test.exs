defmodule MagasinCore.Inventory.OrderPlacedTest do
  use MagasinCore.TestCase

  alias MagasinCore.{Catalog, Email, Quantity}

  alias MagasinCore.Inventory.{StockItemApplicationService, StockItemId, StockItemRepository}
  alias MagasinCore.Sales.{OrderPlaced, OrderRepository}

  @moduletag timeout: 1_000

  # credo:disable-for-this-file Credo.Check.Design.DuplicatedCode

  setup do
    order_id = OrderRepository.next_id()
    product_id = Catalog.ProductRepository.next_id()
    email = Email.new!("foo@bar.com")
    quantity = Quantity.new!(1)

    order_placed_event = %OrderPlaced{
      order_id: order_id,
      email: email,
      product_id: product_id,
      quantity: quantity
    }

    [order_placed_event: order_placed_event]
  end

  describe "a product in stock" do
    test "decreases the count on hand", %{order_placed_event: order_placed_event} do
      previous_stock_item =
        Repo.insert!(%MagasinData.Inventory.StockItemRecord{
          id: StockItemRepository.next_id().value,
          count_on_hand: Quantity.new!(1).value,
          product_id: order_placed_event.product_id.value
        })

      _result = StockItemApplicationService.handle(order_placed_event)

      {:ok, current_stock_item} = StockItemRepository.get(StockItemId.new!(previous_stock_item.id))
      assert current_stock_item.count_on_hand == Quantity.new!(0)
    end
  end

  describe "a product out of stock" do
    test "notifies the product is out of stock", %{order_placed_event: order_placed_event} do
      previous_stock_item =
        Repo.insert!(%MagasinData.Inventory.StockItemRecord{
          id: StockItemRepository.next_id().value,
          count_on_hand: Quantity.new!(1).value,
          product_id: order_placed_event.product_id.value
        })

      _result = StockItemApplicationService.handle(order_placed_event)

      {:ok, current_stock_item} = StockItemRepository.get(StockItemId.new!(previous_stock_item.id))

      assert current_stock_item.count_on_hand == Quantity.new!(0)
    end
  end
end
