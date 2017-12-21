defmodule StorexWeb.BookController do
  use StorexWeb, :controller # calls __using__ macro in storex_web.ex

  def index(conn, _params) do
    render conn, "index.html", books: list_books()
  end

  def show(conn, %{"id" => book_id}) do
    book = list_books()
    |> Enum.find(fn(book) -> book.id == book_id end)

    render conn, "show.html", book: book
  end

  defp list_books do
    [
      %{
        id: "1",
        title: "My first book",
        description: "my first story",
        price: "15.90",
        image_url: "http://www.phoenixforrailsdevelopers.com/books/1.png",
      },
      %{
        id: "2",
        title: "My second book",
        description: "my second story",
        price: "15.90",
        image_url: "http://www.phoenixforrailsdevelopers.com/books/2.png",
      },
      %{
        id: "3",
        title: "My third book",
        description: "my third story",
        price: "15.90",
        image_url: "http://www.phoenixforrailsdevelopers.com/books/3.png",
      },
      %{
        id: "4",
        title: "My forth book",
        description: "my forth story",
        price: "15.90",
        image_url: "http://www.phoenixforrailsdevelopers.com/books/4.png",
      },
    ]
  end
end
