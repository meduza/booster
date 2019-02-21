defmodule ABWeb.Router do
  use ABWeb, :router
  alias ABWeb.Plugs.DeviceToken

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :device_token do
    plug DeviceToken
  end

  scope "/", ABWeb do
    pipe_through :browser
    get "/", PageController, :index
  end


  scope "/api", ABWeb do
    pipe_through [:api, :device_token]
    get "/device/experiments", DeviceController, :index
    # resources "/devices", DeviceController, except: [:new, :edit]
    resources "/experiments", ExperimentController, except: [:new, :edit]
  end
end
