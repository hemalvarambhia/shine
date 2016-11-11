FactoryGirl.define do
  factory :user do
    email 'user2302@example.com'
    password { 'a' * 10 }
  end
end
