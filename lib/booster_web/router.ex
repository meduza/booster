defmodule ABWeb.Router do
  use ABWeb, :router

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

  scope "/", ABWeb do
    pipe_through :browser

    get "/", PageController, :index
  end


  scope "/api", ABWeb do
    pipe_through :api
    resources "/devices", DeviceController, except: [:new, :edit]
    resources "/experiments", ExperimentController, except: [:new, :edit]
  end
end
