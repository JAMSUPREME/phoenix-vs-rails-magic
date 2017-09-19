# In this case, our options (probably) boil
# down to two (or three) choices:
# - in the controller inline (or as a plug)
# - in the model

defmodule MyApp.UserController do
  def index(conn, _params) do
    # my syntax may be off here, forgive me
    active_users = Repo.all(from u in "users",
                            where: u.active == true,
                            select: u)

    render(conn, "index.html", active_users: active_users)
  end
end

defmodule MyApp.User do
  use MyApp.Web, :model

  def active_users(query) do
    from u in query where u.active == true
  end
end