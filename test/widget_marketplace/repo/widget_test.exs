defmodule WidgetMarketplace.Repo.WidgetTest do
  use WidgetMarketplace.DataCase

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User
  alias WidgetMarketplace.Repo.Widget

  describe "changeset/2" do
    test "widgets can be created" do
      {:ok, user} =
        %User{}
        |> User.changeset(%{
          first_name: "test",
          last_name: "name",
          password: "testpass",
          email: "testname@gmail.com"
        })
        |> Repo.insert()

      assert {:ok, widget} =
               %Widget{}
               |> Widget.changeset(%{
                 description: "A great widget",
                 price: 123,
                 user_id: user.id
               })
               |> Repo.insert()

      assert widget.description == "A great widget"
      assert widget.price == 123
      assert widget.user_id == user.id
    end
  end
end
