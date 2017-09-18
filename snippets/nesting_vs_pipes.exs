cat = %Cat{size: :large}
customer = %Customer{club_member: true}

result = Cat.base_price
  |> AdjustPriceForSize.call(cat.size)
  |> AdjustPriceForSale.call
  |> AdjustPriceForHealth.call(cat.health)
  |> AdjustPriceForDiscounts.call(customer)

IO.puts result


defmodule Cat do
  defstruct size: nil, health: :good

  def base_price do
    100
  end
end
defmodule Dog do
  defstruct size: nil, health: :good
end
defmodule Customer do
  defstruct senior_citizen: false, club_member: false
end

# Intentionally made to look like a plug
defmodule AdjustPriceForSize do
  def call(price, size) when size == :small,
    do: price * 0.9
  def call(price, size) when size == :medium,
    do: price
  def call(price, size) when size == :large,
    do: price * 1.3
end

defmodule AdjustPriceForSale do
  def call(price) do
    price * 0.5 # perpetual $20 off
  end
end

defmodule AdjustPriceForHealth do
  def call(price, health) when health == :old,
    do: price * 0.3
  def call(price, _), do: price
end

defmodule AdjustPriceForDiscounts do
  def call(price, customer) do
    price = if customer.senior_citizen,
        do: price * 0.95, else: price
    price = if customer.club_member,
        do: price * 0.80, else: price

    price
  end
end