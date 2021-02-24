defmodule WidgetMarketplaceWeb.Router do
  use WidgetMarketplaceWeb, :router

  pipeline :auth do
    plug WidgetMarketplace.Plug.Authentication
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", WidgetMarketplaceWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/signup", SessionController, :signup
    post "/signup", SessionController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :login

    get "/logout", SessionController, :logout
  end

  scope "/", WidgetMarketplaceWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/market", PageController, :market
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: WidgetMarketplaceWeb.Telemetry
    end
  end
end
