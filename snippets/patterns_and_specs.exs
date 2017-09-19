defmodule User do
  defstruct authorized: true
end

defmodule Options do
  defstruct headers: %{}, ca_cert: nil

  @type t :: %Options{headers: Headers.t, ca_cert: String.t}
end

defmodule Headers do
  defstruct unauthorized: nil, accepts: nil

  @type t :: %Headers{unauthorized: boolean, accepts: String.t}
end


defmodule ApiCaller do

  def get(user, options) when is_nil(user) and is_nil(options) do
    raise "Don't do that"
  end

  @spec get(User.t, Options.t) :: any
  def get(%User{authorized: true}, options), do: authorized_get(options)

  @spec get(any, Options.t) :: any
  def get(_, options), do: unauthorized_get(options)

  defp unauthorized_get(options) do
    IO.puts "No auth GET with options: #{options}"
  end

  defp authorized_get(options) do
    IO.puts "Authorized GET with options: #{options}"
  end
end