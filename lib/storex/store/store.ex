defmodule Storex.Store do
  def list_books() do
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

  def get_book(id) do
    Enum.find(list_books(), fn(book) -> book.id == id end)
  end
end
