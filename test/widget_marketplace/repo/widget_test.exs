defmodule WidgetMarketplace.Repo.WidgetTest do
  use WidgetMarketplace.DataCase

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User
  alias WidgetMarketplace.Repo.Widget

  describe "changeset/2" do
    test "widgets can be created" do
      {:ok, user} =
        %User{}
        |> User.changeset(%{first_name: "test", last_name: "name", email: "testname@gmail.com"})
        |> Repo.insert()

      {:ok, widget} =
        %Widget{}
        |> Widget.changeset(%{description: "A great widget", price: 123, user: user})
        |> Repo.insert()
    end
  end
end
