defmodule Storex.AccountsTest do
  use Storex.DataCase

  alias Storex.Accounts

  @valid_attrs %{
    full_name: "whatever",
    email: "asdf@test.com",
    password: "123456"
  }

  describe "accounts_users" do
    alias Storex.Accounts.User

    test "create_user/1 creates a user when data is valid" do
      {:ok, _user} = Accounts.create_user(@valid_attrs)
      assert length(Repo.all(User)) == 1
    end

    test "create_user/1 does not create a user when data is invalid" do
      {:ok, existing} = Accounts.create_user(@valid_attrs)
      {:error, changeset} = Accounts.create_user(%{})

      assert "can't be blank" in errors_on(changeset).email
      assert "can't be blank" in errors_on(changeset).full_name
      assert "can't be blank" in errors_on(changeset).password

      {:error, changeset} = Accounts.create_user(%{password: "123"})
      assert "should be at least 6 character(s)" in errors_on(changeset).password

      duplicated_email_attrs = %{@valid_attrs | email: existing.email}
      {:error, changeset} = Accounts.create_user(duplicated_email_attrs)
      assert "has already been taken" in errors_on(changeset).email
    end
  end
end
