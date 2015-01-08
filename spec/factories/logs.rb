FactoryGirl.define do
  factory :log do
    start '2014-12-10'
    finish '2014-12-10'
    calling_hours '9.99'
    calls_made 1
    appointment_asks 1
    response_to_appointment_ask 1
    appointment_set 1
    contact_asks 1
    decisions 1
    yes_to_monthly 1
    total_monthly_pledged '9.99'
    total_special_pledged '9.99'
    total_monthly_confirmed '9.99'
    total_special_confirmed '9.99'
    used_contacts 1
    received_contacts 1
  end

end
