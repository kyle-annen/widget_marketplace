defmodule WidgetMarketplace.Guardian do
  @moduledoc """
  Guardian implementation for authentication
  """
  use Guardian, otp_app: :widget_marketplace

  alias WidgetMarketplace.Repo
  alias WidgetMarketplace.Repo.User

  def subject_for_token(%User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id} = claims) do
    IO.inspect(claims, label: "claims")
    user = WidgetMarketplace.get(User, id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
