defmodule WidgetMarketplace.Repo.UserTest do
  use WidgetMarketplace.DataCase

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User

  describe "changeset/2" do
    test "users can be created" do
      {:ok, user} =
        %User{}
        |> User.changeset(%{
          first_name: "test",
          last_name: "name",
          password: "testpass",
          email: "testname@gmail.com"
        })
        |> Repo.insert()

      assert user.first_name == "test"
      assert user.last_name == "name"
      assert user.email == "testname@gmail.com"
    end
  end
end
