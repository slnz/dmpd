FactoryGirl.define do
  factory :contact do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:primary_phone, 215_890_000) { |n| "#{n}" }
    status :base_new
    priority_code :A
  end
end
