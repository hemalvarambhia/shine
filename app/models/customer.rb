class Customer < ActiveRecord::Base
  has_many :customers_shipping_address
  has_one :customers_billing_address
  has_one :billing_address,
          through: :customer_billing_address,
          source: :address

  def primary_shipping_address
    customers_shipping_address.where(primary: true).address
  end
end
