require 'rails_helper'

RSpec.describe Contact::Call::Event, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:call) }
  end

  it { is_expected.to define_enum_for(:state).with(Contact::Call.states) }
  it { is_expected.to define_enum_for(:step).with(Contact::Call.steps) }
end
