defmodule WidgetMarketplace.Plug.Authentication do
  @moduledoc """
  Plug for Guardian authentication
  """
  use Guardian.Plug.Pipeline,
    otp_app: :widget_marketplace,
    error_handler: WidgetMarketplace.ErrorHandler,
    module: WidgetMarketplace.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
