# router.ex
scope "/", Hello do
  pipe_through :browser # Use the default browser stack

  get "/cats/:id/:secret", CatController, :show
  resources "/cats", CatController
end

# cat_controller (via phoenix.gen.html)
def show(conn, %{"id" => id, "secret" => secret}) do
  cat = Repo.get!(Cat, id)
  render(conn, "show.html", cat: cat, secret_name: "#{secret} #{cat.name}")
end

def show(conn, %{"id" => id}) do
  cat = Repo.get!(Cat, id)
  render(conn, "show.html", cat: cat)
end

# show.eex
# Generally one would hope that the view doesn't need to do these kinds of checks
# This is mostly to illustrate the matching
<%= if assigns[:secret_name], do: @secret_name %>