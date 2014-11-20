FactoryGirl.define do
  factory :contact do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    primary_phone '021589000'
    status :base_new
    priority_code :A
  end

end
