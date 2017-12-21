defmodule StorexWeb.LayoutView do
  use StorexWeb, :view

  def items_count(conn) do
    StorexWeb.Plugs.ItemsCount.get(conn)
  end

  def items_total_price(conn) do
    StorexWeb.Plugs.ItemsTotalPrice.get(conn)
  end
end
