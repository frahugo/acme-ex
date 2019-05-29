defmodule MagasinCore.Sales.OrderTest do
  use MagasinCore.TestCase

  alias MagasinCore.Catalog
  alias MagasinCore.Sales.{Order, OrderRepository}

  alias MagasinData.{Email, Quantity}

  describe "placing an order" do
    test "order is placed" do
      product_id = Catalog.ProductRepository.next_id()
      order_id = OrderRepository.next_id()
      quantity = Quantity.new!(1)
      email = Email.new!("foo@bar.com")

      placed_order =
        order_id
        |> Order.place(email, product_id, quantity)
        |> apply_changes

      assert placed_order.id == order_id
      assert placed_order.email == email
      assert placed_order.product_id == product_id
      assert placed_order.quantity == quantity
    end
  end
end