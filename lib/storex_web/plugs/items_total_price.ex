defmodule StorexWeb.Plugs.ItemsTotalPrice do
  import Plug.Conn
  alias Storex.Sales
  alias StorexWeb.Plugs

  @assign_name :items_total_price

  def init(opts), do: opts

  def call(conn, _opts) do
    cart = Plugs.Cart.get(conn)
    line_items = Sales.list_line_items(cart)

    assign(conn, @assign_name, Sales.line_items_total_price(line_items))
  end

  def get(conn) do
    conn.assigns[@assign_name]
  end
end

