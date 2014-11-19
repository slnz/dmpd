FactoryGirl.define do
  factory :call_session do
    user
    partner factory: :user
  end

end
