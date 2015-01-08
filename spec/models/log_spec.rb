require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start) }
    it { is_expected.to validate_presence_of(:finish) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'fetch_statistics' do
    it 'sets_calling_hours' do
      contact = create(:contact, user: user)
      contact.calls.create(end_time: time + 1.hour)
      log = generate_log
      expect(log.calling_hours).to eq(1)
    end

    it 'set_calls_made' do
      contact = create(:contact, user: user)
      contact.calls.create(end_time: time + 1.hour)
      contact.calls.create(end_time: time + 1.hour)
      log = generate_log
      expect(log.calls_made).to eq(2)
    end

    it 'set_appointment_set' do
      contact = create(:contact, user: user)
      contact.appointments.create
      contact.appointments.create
      log = generate_log
      expect(log.appointment_set).to eq(2)
    end

    it 'set_total_special_confirmed' do
      create(:contact, user: user, frequency: 0, amount: 100, confirmed: true)
      create(:contact, user: user, frequency: 0, amount: 50)
      create(:contact, user: user, frequency: 1, amount: 100, confirmed: true)
      create(:contact, user: user, frequency: 0.5, amount: 50)
      create(:contact, user: user)
      log = generate_log
      expect(log.yes_to_monthly).to eq(2)
    end

    it 'set_total_monthly_pledged' do
      create(:contact, user: user, frequency: 1, amount: 100)
      create(:contact, user: user, frequency: 0.5, amount: 50)
      log = generate_log
      expect(log.total_monthly_pledged).to eq(125)
    end

    it 'set_total_special_pledged' do
      create(:contact, user: user, frequency: 0, amount: 100)
      create(:contact, user: user, frequency: 0, amount: 50)
      log = generate_log
      expect(log.total_special_pledged).to eq(150)
    end

    it 'set_total_monthly_confirmed' do
      create(:contact, user: user, frequency: 1, amount: 100, confirmed: true)
      create(:contact, user: user, frequency: 0.5, amount: 50)
      log = generate_log
      expect(log.total_monthly_confirmed).to eq(100)
    end

    it 'set_total_special_confirmed' do
      create(:contact, user: user, frequency: 0, amount: 100, confirmed: true)
      create(:contact, user: user, frequency: 0, amount: 50)
      log = generate_log
      expect(log.total_special_confirmed).to eq(100)
    end

    it 'set_appointment_asks' do
      contact = create(:contact, user: user)
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:new_contact],
             state: Contact::Call.states[:no_appointment])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:new_contact],
             state: Contact::Call.states[:got_appointment])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:new_contact],
             state: Contact::Call.states[:must_callback])
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:new_contact],
                     state: Contact::Call.states[:must_callback])
      event.created_at = time + 2.weeks
      event.save
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:new_contact],
                     state: Contact::Call.states[:must_callback])
      event.created_at = time + 2.weeks
      event.save
      log = generate_log
      expect(log.appointment_asks).to eq(3)
    end

    it 'set_response_to_appointment_ask' do
      contact = create(:contact, user: user)
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:new_contact],
             state: Contact::Call.states[:no_appointment])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:new_contact],
             state: Contact::Call.states[:got_appointment])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:new_contact],
             state: Contact::Call.states[:must_callback])
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:new_contact],
                     state: Contact::Call.states[:must_callback])
      event.created_at = time + 2.weeks
      event.save
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:new_contact],
                     state: Contact::Call.states[:must_callback])
      event.created_at = time + 2.weeks
      event.save
      create(:appointment, contact: contact)
      event.created_at = time + 2.weeks
      event.save
      log = generate_log
      expect(log.response_to_appointment_ask).to eq(2)
    end

    it 'set_decisions' do
      contact = create(:contact, user: user)
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:must_callback_for_decision],
             state: Contact::Call.states[:got_support])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:must_callback_for_decision],
             state: Contact::Call.states[:no_support])
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:must_callback_for_decision],
                     state: Contact::Call.states[:no_support])
      event.created_at = time + 2.weeks
      event.save
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:must_callback_for_decision],
                     state: Contact::Call.states[:got_support])
      event.created_at = time + 2.weeks
      event.save
      create(:appointment,
             contact: contact,
             result: Contact::Appointment.results[:support])
      create(:appointment,
             contact: contact,
             result: Contact::Appointment.results[:no_support])
      appointment = create(:appointment,
                           contact: contact,
                           result: Contact::Appointment.results[:support])
      appointment.created_at = time + 2.weeks
      appointment.save
      appointment = create(:appointment,
                           contact: contact,
                           result: Contact::Appointment.results[:no_support])
      appointment.created_at = time + 2.weeks
      appointment.save
      log = generate_log
      expect(log.decisions).to eq(4)
    end

    it 'set_contact_asks' do
      contact = create(:contact, user: user)
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:must_callback_for_contacts],
             state: Contact::Call.states[:got_contacts])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:must_callback_for_contacts],
             state: Contact::Call.states[:no_contacts])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:must_callback_for_contacts],
             state: Contact::Call.states[:must_callback])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:ask_for_contacts],
             state: Contact::Call.states[:got_contacts])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:ask_for_contacts],
             state: Contact::Call.states[:no_contacts])
      call = create(:call, contact: contact, end_time: time + 10.minutes)
      create(:event,
             call: call,
             step: Contact::Call.steps[:ask_for_contacts],
             state: Contact::Call.states[:must_callback])
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:must_callback_for_contacts],
                     state: Contact::Call.states[:must_callback])
      event.created_at = time + 2.weeks
      event.save
      call = create(:call, contact: contact, end_time: time + 3.weeks)
      event = create(:event,
                     call: call,
                     step: Contact::Call.steps[:ask_for_contacts],
                     state: Contact::Call.states[:must_callback])
      event.created_at = time + 2.weeks
      event.save
      log = generate_log
      expect(log.contact_asks).to eq(6)
    end

    it 'set_received_contacts' do
      contact = create(:contact, user: user)
      create(:contact, user: user, referer_id: contact.id)
      create(:contact, user: user, referer_id: contact.id)
      create(:contact, user: user, referer_id: contact.id)
      log = generate_log
      expect(log.received_contacts).to eq(3)
    end

    it 'set_used_contacts' do
      create(:contact,
             user: user,
             status: :base_new)
      create(:contact,
             user: user,
             status: :callback_for_appointment)
      create(:contact,
             user: user,
             status: :appointment_set)
      create(:contact,
             user: user,
             status: :maintain_call_in_a_year)
      log = generate_log
      expect(log.used_contacts).to eq(3)
    end

    def generate_log
      create(
        :log,
        user: user,
        start: time.to_date.beginning_of_week,
        finish: (time.to_date + 1.week).beginning_of_week - 1.day)
    end

    def time
      Time.now.utc
    end
  end
end
