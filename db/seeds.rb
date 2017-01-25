# This file should contain all the record creation needed to seed
# the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside
# the db with db:setup).
#
if Customer.all.count == 0
  350_000.times do |i|
    Customer.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: "#{Faker::Internet.user_name}#{i}",
      email: Faker::Internet.user_name + i.to_s +
             "@#{Faker::Internet.domain_name}"
    )
  end
end
[
  { name: "Alabama"           , code: "AL"},
  { name: "Alaska"            , code: "AK"},
  { name: "Arizona"           , code: "AZ"},
  { name: "Arkansas"          , code: "AR"},
  { name: "California"        , code: "CA"},
  { name: "Colorado"          , code: "CO"},
  { name: "Connecticut"       , code: "CT"},
  { name: "Delaware"          , code: "DE"},
  { name: "Dist. of Columbia" , code: "DC"},
  { name: "Florida"           , code: "FL"},
  { name: "Georgia"           , code: "GA"},
  { name: "Hawaii"            , code: "HI"},
  { name: "Idaho"             , code: "ID"},
  { name: "Illinois"          , code: "IL"},
  { name: "Indiana"           , code: "IN"},
  { name: "Iowa"              , code: "IA"},
  { name: "Kansas"            , code: "KS"},
  { name: "Kentucky"          , code: "KY"},
  { name: "Louisiana"         , code: "LA"},
  { name: "Maine"             , code: "ME"},
  { name: "Maryland"          , code: "MD"},
  { name: "Massachusetts"     , code: "MA"},
  { name: "Michigan"          , code: "MI"},
  { name: "Minnesota"         , code: "MN"},
  { name: "Mississippi"       , code: "MS"},
  { name: "Missouri"          , code: "MO"},
  { name: "Montana"           , code: "MT"},
  { name: "Nebraska"          , code: "NE"},
  { name: "Nevada"            , code: "NV"},
  { name: "New Hampshire"     , code: "NH"},
  { name: "New Jersey"        , code: "NJ"},
  { name: "New Mexico"        , code: "NM"},
  { name: "New York"          , code: "NY"},
  { name: "North Carolina"    , code: "NC"},
  { name: "North Dakota"      , code: "ND"},
  { name: "Ohio"              , code: "OH"},
  { name: "Oklahoma"          , code: "OK"},
  { name: "Oregon"            , code: "OR"},
  { name: "Pennsylvania"      , code: "PA"},
  { name: "Rhode Island"      , code: "RI"},
  { name: "South Carolina"    , code: "SC"},
  { name: "South Dakota"      , code: "SD"},
  { name: "Tennessee"         , code: "TN"},
  { name: "Texas"             , code: "TX"},
  { name: "Utah"              , code: "UT"},
  { name: "Vermont"           , code: "VT"},
  { name: "Virginia"          , code: "VA"},
  { name: "Washington"        , code: "WA"},
  { name: "West Virginia"     , code: "WV"},
  { name: "Wisconsin"         , code: "WI"},
  { name: "Wyoming"           , code: "WY"}
].each do |state|
  State.find_or_create_by! state
end

# Helper method to create a billing address for a customer
def create_billing_address(customer_id,state)
  billing_address = Address.create!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: state,
    zipcode: Faker::Address.zip
  )

  CustomersBillingAddress.create!(
    customer_id: customer_id,
    address: billing_address)
end

# Helper method to create a shipping address for a customer
def create_shipping_address(customer_id,state,is_primary)
  shipping_address = Address.create!(
       street: Faker::Address.street_address,
         city: Faker::Address.city,
        state: state,
      zipcode: Faker::Address.zip
  )

  CustomersShippingAddress.create!(
    customer_id: customer_id,
    address: shipping_address,
    primary: is_primary
  )
end

# Cache the number of states so we don't have to query
# ecah time through
all_states = State.all.to_a

# For all customers
Customer.find_each do |customer|
  # Do not recreate addresses if this customer has them
  next if customer.customers_shipping_address.any?
  puts "Creating addresses for #{customer.id}..."

  # Create a billing address for them
  create_billing_address(customer.id,all_states.sample)

  # Create a random number of shipping addresses, making
  # sure we create at least 1
  num_shipping_addresses = rand(4) + 1

  num_shipping_addresses.times do |i|
    # Create the shipping address, setting the first one
    # we create as the "primary"
    create_shipping_address(customer.id,all_states.sample,i == 0)
  end
end
