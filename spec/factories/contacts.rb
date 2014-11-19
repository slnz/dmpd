FactoryGirl.define do
  factory :contact do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    primary_phone do
      Faker::PhoneNumber.cell_phone.to_s.phony_formatted(format: :international)
    end
    status :base_new
    priority_code :A
  end

end
