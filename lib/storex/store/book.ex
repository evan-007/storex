defmodule Storex.Store.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storex.Store.Book

  schema "store_books" do
    field :description, :string
    field :image_url, :string
    field :price, :decimal
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    book
    |> cast(attrs, [:title, :description, :price, :image_url])
    |> validate_required([:title, :description, :price, :image_url])
    |> validate_max_price()
  end

  def create_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Storex.Repo.insert()
  end

  defp validate_max_price(changeset) do
    is_valid = get_change(changeset, :price)
    |> Decimal.new
    |> Decimal.cmp(Decimal.new(99.99))

    case is_valid do
      :gt ->
        add_error(changeset, :price, "Price is not valid, must be less than 99.99")
      :lt ->
        changeset
    end
  end
end
