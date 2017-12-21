# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Storex.Repo.insert!(%Storex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
books = [
  %{
    title: "My first book",
    description: "my first story",
    price: "15.90",
    image_url: "http://www.phoenixforrailsdevelopers.com/books/1.png",
  },
  %{
    title: "My second book",
    description: "my second story",
    price: "15.90",
    image_url: "http://www.phoenixforrailsdevelopers.com/books/2.png",
  },
  %{
    title: "My third book",
    description: "my third story",
    price: "15.90",
    image_url: "http://www.phoenixforrailsdevelopers.com/books/3.png",
  },
  %{
    title: "My forth book",
    description: "my forth story",
    price: "15.90",
    image_url: "http://www.phoenixforrailsdevelopers.com/books/4.png",
  },
]

Enum.each(books, fn(attrs) ->
  changeset = Storex.Store.Book.changeset(%Storex.Store.Book{}, attrs)
  Storex.Repo.insert!(changeset)
end)
