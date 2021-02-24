defmodule WidgetMarketplaceTest do
  use WidgetMarketplace.DataCase

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.Transaction
  alias WidgetMarketplace.Repo.User
  alias WidgetMarketplace.Repo.Widget

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

  describe "get_user_balance/1" do
    test "returns the users balance" do
      {:ok, user} = WidgetMarketplace.create(User, @valid_user_atrrs)

      {:ok, _transaction} =
        WidgetMarketplace.create(Transaction, %{seller_id: user.id, amount: 1000})

      assert 1000 = WidgetMarketplace.get_user_balance(user)
    end

    test "returns the users balance on both sides of the transaction" do
      {:ok, seller} = WidgetMarketplace.create(User, @valid_user_atrrs)

      {:ok, widget} =
        %Widget{}
        |> Widget.changeset(%{
          description: "A great widget",
          price: 123,
          user_id: seller.id
        })
        |> Repo.insert()

      {:ok, buyer} =
        WidgetMarketplace.create(
          User,
          Map.merge(@valid_user_atrrs, %{email: "another@email.com"})
        )

      {:ok, _buyer_add_funds_transaction} =
        WidgetMarketplace.create(Transaction, %{seller_id: buyer.id, amount: 1000})

      {:ok, _transaction} =
        WidgetMarketplace.create(Transaction, %{
          seller_id: seller.id,
          amount: 200,
          buyer_id: buyer.id,
          widget_id: widget.id
        })

      assert 800 = WidgetMarketplace.get_user_balance(buyer)
      assert 190.0 = WidgetMarketplace.get_user_balance(seller)
    end
  end

  describe "purchase_widget/4" do
    test "can be purchased if the account balance is greater than or equal to price" do
      {:ok, seller} = WidgetMarketplace.create(User, @valid_user_atrrs)

      {:ok, widget} =
        %Widget{}
        |> Widget.changeset(%{
          description: "A great widget",
          price: 123,
          user_id: seller.id
        })
        |> Repo.insert()

      {:ok, buyer} =
        WidgetMarketplace.create(
          User,
          Map.merge(@valid_user_atrrs, %{email: "another@email.com"})
        )

      {:ok, _buyer_add_funds_transaction} =
        WidgetMarketplace.create(Transaction, %{seller_id: buyer.id, amount: 1000})

      assert {:ok, _transaction} =
               WidgetMarketplace.purchase_widget(buyer, seller.id, widget.id, widget.price)
    end

    test "cannot be purchased if the account balance less than the price" do
      {:ok, seller} = WidgetMarketplace.create(User, @valid_user_atrrs)

      {:ok, widget} =
        %Widget{}
        |> Widget.changeset(%{
          description: "A great widget",
          price: 123,
          user_id: seller.id
        })
        |> Repo.insert()

      {:ok, buyer} =
        WidgetMarketplace.create(
          User,
          Map.merge(@valid_user_atrrs, %{email: "another@email.com"})
        )

      {:ok, _buyer_add_funds_transaction} =
        WidgetMarketplace.create(Transaction, %{seller_id: buyer.id, amount: 100})

      assert {:error, :insufficient_funds} =
               WidgetMarketplace.purchase_widget(buyer, seller.id, widget.id, widget.price)
    end
  end
end
