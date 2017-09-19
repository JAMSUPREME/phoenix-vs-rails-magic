defmodule MyApp.CatController do
  use MyApp.Web, :controller
end

defmodule MyApp.PurchaseCatController do
  use MyApp.Web, :controller

  # controller-specific plug (not worth a pipeline in the router)
  plug :fill_cat_data

end

# A lot of the changes here actually go into the router
# The perceived boon is that everything here goes through a predictable path before hitting our controller
defmodule MyApp.Router do
  use MyApp.Web, :router

  pipeline :browser do
    # ...
  end

  # We make this its own "pipeline" that endpoints opt into
  pipeline :authorized do
    plug MyApp.Authentication
    plug Rumbl.Authorization
  end

  scope "/", MyApp do
    pipe_through :browser # Use the default browser stack

    get "/", CatController, :index
    get "/buy_cat", PurchaseCatController, :index
  end

  scope "/", MyApp do
    pipe_through [:browser, :authenticated]

    get "/show_cats", CatController, :show
  end
end