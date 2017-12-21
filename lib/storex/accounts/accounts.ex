defmodule Storex.Accounts do
  import Ecto.Query, warn: false
  alias Storex.Repo
  alias Storex.Accounts.User

  def create_user(attrs \\ %User{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def new_user() do
    User.changeset(%User{}, %{})
  end

  def authenticate_user(email, password) do
    %User{}
    |> where(email: ^email)
    |> where(password: ^password)
    |> Repo.get_one()
  end
end
