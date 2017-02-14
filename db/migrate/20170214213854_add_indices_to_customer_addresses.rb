class AddIndicesToCustomerAddresses < ActiveRecord::Migration
  def change
    add_index(
      :customers_billing_addresses, :customer_id,
      name: 'customers_billing_addresses_customer_id') 
    add_index(
      :customers_shipping_addresses, :customer_id,
      name: 'customers_shipping_addresses_customer_id')
  end
end
