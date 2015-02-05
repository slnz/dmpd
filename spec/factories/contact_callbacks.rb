FactoryGirl.define do
  factory :contact_callback, class: 'Contact::Callback' do
    contact_id 1
    time '2014-11-19 15:56:35'
    notes 'MyText'
    state 1
  end
end
