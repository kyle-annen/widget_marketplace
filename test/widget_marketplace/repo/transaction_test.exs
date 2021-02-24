defmodule WidgetMarketplace.Repo.TransactionTest do
  use WidgetMarketplace.DataCase

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.Transaction
  alias WidgetMarketplace.Repo.User
  alias WidgetMarketplace.Repo.Widget

  describe "changeset/2" do
    test "transactions can be created" do
      {:ok, tam} =
        %User{}
        |> User.changeset(%{
          first_name: "Tam",
          last_name: "Nguyen",
          password: "testpass",
          email: "testname@gmail.com"
        })
        |> Repo.insert()

      {:ok, bob} =
        %User{}
        |> User.changeset(%{
          first_name: "Bob",
          last_name: "Tsang",
          password: "onetwo",
          email: "bob@gmail.com"
        })
        |> Repo.insert()

      {:ok, widget} =
        %Widget{}
        |> Widget.changeset(%{description: "A great widget", price: 123, user_id: bob.id})
        |> Repo.insert()

      assert {:ok, transaction} =
               %Transaction{}
               |> Transaction.changeset(%{
                 seller_id: bob.id,
                 buyer_id: tam.id,
                 widget_id: widget.id,
                 amount: widget.price
               })
               |> Repo.insert()

      assert transaction.seller_id == bob.id
      assert transaction.buyer_id == tam.id
      assert transaction.amount == widget.price
    end
  end
end
