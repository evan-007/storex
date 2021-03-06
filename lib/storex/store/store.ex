defmodule Storex.Store do
  alias Storex.Repo
  alias Storex.Store.Book

  def list_books() do
    Repo.all(Book)
  end

  def get_book(id) do
    Repo.get(Book, id)
  end

  def create_book(attrs \\ %Book{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end
end
