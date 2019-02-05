FactoryBot.define do
  factory :order do
    customer_name   { Faker::Name.name  }
    full_address    { Faker::Address.full_address }
    zip_code        { Faker::Address.zip_code }
    shipping_method { "country_delivery_within_hours" }
  end
end