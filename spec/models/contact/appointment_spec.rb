require 'rails_helper'

RSpec.describe Contact::Appointment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:contact) }
  end
end
