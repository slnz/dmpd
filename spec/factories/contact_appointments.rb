FactoryGirl.define do
  factory :contact_appointment, class: 'Contact::Appointment' do
    time '2014-11-19 11:09:06'
    support false
    amount '9.99'
    contact_id 1
    reccuring false
    frequency '9.99'
    notes 'MyText'
    address 'MyString'
    gift_date '2014-11-19'
    gift_confirmed_date '2014-11-19'
  end

end
