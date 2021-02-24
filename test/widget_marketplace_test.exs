defmodule WidgetMarketplaceTest do
  use WidgetMarketplace.DataCase

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User

  @valid_user_atrrs %{
    first_name: "test",
    last_name: "user",
    password: "valid_pass",
    email: "testuser@test.com"
  }

  describe "create/2" do
    test "creates a record with valid attrs" do
      assert {:ok, _user} = WidgetMarketplace.create(User, @valid_user_atrrs)
    end
  end

  describe "get/2" do
    test "returns the record if it exists" do
      {:ok, %User{id: id}} =
        %User{}
        |> User.changeset(@valid_user_atrrs)
        |> Repo.insert()

      user = WidgetMarketplace.get(User, id)
      assert user.id == id
    end
  end

  describe "authenticate/2" do
    test "returns error if the email is not found" do
      assert {:error, :invalid_credentials} =
               WidgetMarketplace.authenticate("bad_email@test.com", "some-pass")
    end

    test "returns error if the password is invalid" do
      {:ok, _user} = WidgetMarketplace.create(User, @valid_user_atrrs)

      assert {:error, :invalid_credentials} =
               WidgetMarketplace.authenticate("testuser@test.com", "badpass")
    end

    test "returns the user if authenticated" do
      {:ok, _user} = WidgetMarketplace.create(User, @valid_user_atrrs)

      assert {:ok, _user} = WidgetMarketplace.authenticate("testuser@test.com", "valid_pass")
    end
  end
end
