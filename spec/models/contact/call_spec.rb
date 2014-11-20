require 'rails_helper'

RSpec.describe Contact::Call, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:contact) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
  end

  it do
    is_expected.to define_enum_for(:state).with(
      [:not_in, :must_callback, :got_appointment, :no_appointment,
       :got_contacts, :no_contacts, :got_support, :no_support,
       :answered, :line_busy, :no_answer]
    )
  end
  it do
    is_expected.to define_enum_for(:step).with(
      [:init, :start_call, :new_contact,
       :must_callback_for_contacts, :must_callback_for_decision,
       :ask_for_contacts, :appointment, :callback, :support,
       :not_present, :input_contacts, :stats, :end]
    )
  end
end
