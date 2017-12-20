defmodule StorexWeb.BookController do
  use StorexWeb, :controller # calls __using__ macro in storex_web.ex

  def index(conn, _params) do
    render conn, "index.html"
  end
end
