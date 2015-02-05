require 'rails_helper'

RSpec.describe CallSession, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:partner).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
  end

  describe '#end_session' do
    let(:call_session) { create(:call_session) }
    it 'sets end time to now' do
      call_session.end_session
      expect(call_session.end_time.round).to eq(Time.now.round)
    end
  end
end
