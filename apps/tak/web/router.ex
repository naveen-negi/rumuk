defmodule Tak.Router do
  use Tak.Web, :router

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

  scope "/api/users", Tak do
    pipe_through :api # Use the default browser stack

    get "/:user_id/notifications", NotificationController, :get
    post "/:user_id/notifications", NotificationController, :create
    post "/:user_id/basic_info", UserController, :create_basic_info
    post "/:user_id/educational_details", UserController, :create_educational_details
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tak do
  #   pipe_through :api 
  # end
end
