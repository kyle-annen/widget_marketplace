defmodule WidgetMarketplace.ErrorHandler do
  @moduledoc """
  Error handler.
  """
  @behaviour Guardian.Plug.ErrorHandler

  import Plug.Conn
  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    IO.inspect(type, label: "#{__MODULE__} auth error")
    body = to_string(type)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end
