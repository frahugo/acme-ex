defmodule Magasin.Sales.PlaceOrderTest do
  use Magasin.TestCase

  alias CivilCode.Validation
  alias Magasin.{Address, Catalog, Email, PostalCode, Quantity}
  alias Magasin.Sales.{OrderRepository, PlaceOrder}

  describe "to_domain" do
    test "valid command returns domain values" do
      order_id = OrderRepository.next_id()
      product_id = Catalog.ProductRepository.next_id()

      command = %PlaceOrder{
        order_id: order_id.value,
        email: "foo@bar.com",
        product_id: product_id.value,
        quantity: 1,
        line_items: [%{product_id: product_id.value, quantity: 1}],
        shipping_address: %{
          street_address: "1 Main St",
          city: "Montreal",
          postal_code: "H2T1S6"
        }
      }

      {:ok, domain_values} = PlaceOrder.to_domain(command)

      assert domain_values.order_id == order_id
      assert domain_values.email == Email.new!("foo@bar.com")
      assert domain_values.product_id == product_id
      assert domain_values.quantity == Quantity.new!(1)
      assert domain_values.shipping_address == Address.new!(command.shipping_address)
      assert domain_values.shipping_address.postal_code == PostalCode.new!("H2T1S6")

      assert line_item = List.first(domain_values.line_items)
      assert line_item.quantity == Quantity.new!(1)
      assert line_item.product_id == product_id
    end

    test "invalid command returns validation error" do
      order_id = OrderRepository.next_id()
      product_id = Catalog.ProductRepository.next_id()

      command = %PlaceOrder{
        order_id: order_id.value,
        email: nil,
        product_id: product_id.value,
        quantity: -1,
        line_items: nil,
        shipping_address: %{postal_code: ":invalid:"}
      }

      {:error, validation_error} = PlaceOrder.to_domain(command)

      assert %Validation{} = validation_error
      assert validation_error.data == command
      assert {:email, "can't be blank"} in validation_error.errors
      assert {:quantity, "is invalid"} in validation_error.errors
      assert {:city, "can't be blank"} in validation_error.errors[:shipping_address]
      assert {:postal_code, "is invalid"} in validation_error.errors[:shipping_address]
    end
  end
end
