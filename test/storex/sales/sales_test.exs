defmodule Storex.SalesTest do
  use Storex.DataCase

  alias Storex.{Sales, Store}

  describe "carts" do
    alias Storex.Sales.Cart

    test "create_cart/0 creates a cart" do
      assert {:ok, %Cart{}} = Sales.create_cart()
    end

    test "get_cart!/1 finds a cart" do
      {:ok, cart} = Sales.create_cart()

      assert Sales.get_cart!(cart.id) == cart
    end

    test "add_book_to_cart/2 creates or increments a line_item" do
      {:ok, book} = Store.create_book(%{
        title: "title",
        description: "description",
        image_url: "whatever.jpg",
        price: "22.25",
      })

      {:ok, cart} = Sales.create_cart()
      {:ok, line_item_1} = Sales.add_book_to_cart(book, cart)
      {:ok, line_item_2} = Sales.add_book_to_cart(book, cart)

      assert line_item_1.quantity == 1
      assert line_item_1.book_id == book.id
      assert line_item_1.cart_id == cart.id
      assert line_item_1.id == line_item_2.id
      assert line_item_2.quantity == 2
    end

    test "remove_book_from_cart/2 decrements or deletes a line_item" do
      {:ok, book} = Store.create_book(%{
        title: "title",
        description: "description",
        image_url: "whatever.jpg",
        price: "22.25",
      })

      {:ok, cart} = Sales.create_cart()
      Sales.add_book_to_cart(book, cart)
      Sales.add_book_to_cart(book, cart)

      {:ok, line_item} = Sales.remove_book_from_cart(book, cart)

      assert line_item.quantity == 1

      Sales.remove_book_from_cart(book, cart)

      assert_raise Ecto.NoResultsError, fn ->
        Sales.remove_book_from_cart(book, cart)
      end
    end

    test "list_line_items/2 lists all line_items for a cart" do
      {:ok, book_1} = Store.create_book(%{
        title: "book 1",
        description: "description",
        image_url: "whatever.jpg",
        price: "22.25",
      })
      {:ok, book_2} = Store.create_book(%{
        title: "book 2",
        description: "description",
        image_url: "whatever.jpg",
        price: "22.25",
      })

      {:ok, cart_1} = Sales.create_cart()
      {:ok, cart_2} = Sales.create_cart()
      Sales.add_book_to_cart(book_1, cart_1)
      Sales.add_book_to_cart(book_2, cart_2)

      [line_item_1] = Sales.list_line_items(cart_1)
      assert line_item_1.book == book_1

      [line_item_2] = Sales.list_line_items(cart_2)
      assert line_item_2.book == book_2
    end

    test "line_items_quantity_count/1 return the number of line_items" do
      {:ok, book} = Store.create_book(%{
        title: "book 1",
        description: "description",
        image_url: "whatever.jpg",
        price: "22.25",
      })
      {:ok, cart} = Sales.create_cart()

      Sales.add_book_to_cart(book, cart)
      Sales.add_book_to_cart(book, cart)

      line_items = Sales.list_line_items(cart)
      count = Sales.line_items_quantity_count(line_items)

      assert 2 == count
    end

    test "line_items_total_price/1 return the price of line_items" do
      {:ok, book} = Store.create_book(%{
        title: "book 1",
        description: "description",
        image_url: "whatever.jpg",
        price: "5.00",
      })
      {:ok, cart} = Sales.create_cart()

      Sales.add_book_to_cart(book, cart)
      Sales.add_book_to_cart(book, cart)
      line_items = Sales.list_line_items(cart)

      assert Sales.line_items_total_price(line_items) == Decimal.new("10.00")
    end
  end
end
