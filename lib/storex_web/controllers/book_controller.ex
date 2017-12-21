defmodule StorexWeb.BookController do
  use StorexWeb, :controller # calls __using__ macro in storex_web.ex
  alias Storex.Store

  def index(conn, _params) do
    render conn, "index.html", books: Store.list_books()
  end

  def show(conn, %{"id" => book_id}) do
    book = Store.get_book(book_id)

    render conn, "show.html", book: book
  end
end
