require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { build(:contact) }

  describe 'associations' do
    it { is_expected.to have_one(:referer).class_name('Contact') }
    it { is_expected.to have_many(:calls).dependent(:destroy) }
    it { is_expected.to belong_to(:user).counter_cache(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:primary_phone) }
    it { is_expected.to validate_presence_of(:priority_code) }
    it { is_expected.to validate_presence_of(:status) }
  end

  it { is_expected.to define_enum_for(:priority_code).with([:A, :B, :C]) }

  it do
    is_expected.to define_enum_for(:status).with(
      [:base_new,
       :base_not_back_until,
       :base_office_phone_only,
       :base_needs_research,
       :callback_for_appointment,
       :callback_for_decision,
       :callback_for_contacts,
       :appointment_set,
       :appointment_none,
       :appointment_no_support,
       :appointment_new_ministry_partner,
       :maintain_call_in_a_year,
       :maintain_would_have_met,
       :maintain_on_list]
    )
  end
end
