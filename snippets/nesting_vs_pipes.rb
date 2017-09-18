class PedAdoptionService
  def calculate_fee(pet, customer)
    base_price = pet.base_price

    price = modify_base_price(pet.size, base_price)

    price = SaleService.sale_price(pet, price)

    Discounter.new.calculate_discounts(price, customer)
  end

  def modify_base_price(pet_size, base_price)
    case pet_size
      when :small
        base_price * 0.9
      when :medium
        base_price
      when :large
        base_price * 1.3
    end
  end
end

class Cat
  attr_accessor :size, :health

  def base_price
    100
  end
end

class Dog
  attr_accessor :size, :health

  def base_price
    150
  end
end

class Customer
  attr_accessor :senior_citizen, :club_member
end

class SaleService
  class << self
    def sale_price(pet, current_price)
      current_price = current_price - PetsApi.company_wide_sale if PetsApi.company_wide_sale
      current_price = current_price * 0.3 if pet.health == :old

      current_price
    end
  end
end

class PetsApi
  def self.company_wide_sale()
    # Imagine we check some API that indicates a global sale
    # $20 off!
    20
  end
end

class Discounter
  def calculate_discounts(original_price, customer)
    original_price = original_price * 0.95 if customer.senior_citizen
    original_price = original_price * 0.80 if customer.club_member

    original_price
  end
end

cat_to_buy = Cat.new
cat_to_buy.size = :large

customer = Customer.new
customer.senior_citizen = true

puts PedAdoptionService.new.calculate_fee(cat_to_buy, customer)

