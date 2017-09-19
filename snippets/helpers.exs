# In this case, our options (probably) boil down to two (or three) choices:
# in the controller (one-time usage, perhaps as an inline or distinct plug)
# in the model (multi-usage, only applies to users)

defmodule MyApp.UserController do
  def index(conn, _params) do
    active_users = Repo.all(from u in "users",
                            where: u.active == true,
                            select: u) # my syntax may be off here, forgive me

    render(conn, "index.html", active_users: active_users)
  end
end

defmodule MyApp.User do
  use MyApp.Web, :model

  def active_users(query) do
    from u in query where u.active == true
  end
end
