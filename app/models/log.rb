# rubocop:disable Metrics/ClassLength
class Log < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :start, presence: true
  validates :finish, presence: true
  before_create :fetch_statistics

  # rubocop:disable Metrics/MethodLength
  def fetch_statistics
    unless Time.now.utc.to_date >= start && Time.now.utc.to_date <= finish
      return
    end
    set_calling_hours
    set_calls_made
    set_appointment_asks
    set_response_to_appointment_ask
    set_appointment_set
    set_contact_asks
    set_decisions
    set_yes_to_monthly
    set_total_monthly_pledged
    set_total_special_pledged
    set_total_monthly_confirmed
    set_total_special_confirmed
    set_used_contacts
    set_received_contacts
    save if persisted?
  end
  # rubocop:enable Metrics/MethodLength

  def range
    (start - 1.day)..(finish + 1.day)
  end

  private

  def set_calling_hours
    self.calling_hours = 0
    user.calls.where(created_at: range)
      .where('end_time IS NOT NULL').each do |call|
      self.calling_hours += call.decorate.length
    end
    self.calling_hours = calling_hours.round
  end

  def set_calls_made
    self.calls_made = user.calls.where(created_at: range).count
  end

  def set_appointment_asks
    self.appointment_asks =
      user.events.where(
        created_at: range,
        state: [Contact::Call.states[:no_appointment],
                Contact::Call.states[:got_appointment],
                Contact::Call.states[:must_callback]]).count
  end

  def set_response_to_appointment_ask
    self.response_to_appointment_ask =
      user.events.where(
        created_at: range,
        state: Contact::Call.states[:no_appointment]).count +
      user.appointments.where(created_at: range).count
  end

  def set_appointment_set
    self.appointment_set =
      user.appointments.where(created_at: range).count
  end

  def set_contact_asks
    self.contact_asks =
      user.events.where(
        created_at: range,
        step: [Contact::Call.steps[:must_callback_for_contacts],
               Contact::Call.steps[:ask_for_contacts]],
        state: [Contact::Call.states[:got_contacts],
                Contact::Call.states[:no_contacts],
                Contact::Call.states[:must_callback]]).count
  end

  def set_decisions
    self.decisions =
      user.events.where(
        created_at: range,
        state: [Contact::Call.states[:got_support],
                Contact::Call.states[:no_support]]).count +
      user.appointments.where(
        created_at: range,
        result: [Contact::Appointment.results[:support],
                 Contact::Appointment.results[:no_support]]).count
  end

  def set_yes_to_monthly
    self.yes_to_monthly =
      user.contacts.where('amount > 0 AND frequency > 0').count
  end

  def set_total_monthly_pledged
    self.total_monthly_pledged =
      user.contacts.where('frequency > 0').sum('amount / frequency')
  end

  def set_total_special_pledged
    self.total_special_pledged =
      user.contacts.where('frequency = 0').sum(:amount)
  end

  def set_total_monthly_confirmed
    self.total_monthly_confirmed =
      user.contacts.confirmed.where('frequency > 0').sum('amount / frequency')
  end

  def set_total_special_confirmed
    self.total_special_confirmed =
      user.contacts.confirmed.where('frequency = 0').sum(:amount)
  end

  def set_used_contacts
    self.used_contacts =
      user.contacts.where.not(category: Contact.categories[:base]).count
  end

  def set_received_contacts
    self.received_contacts =
      user.contacts.where.not(referer_id: nil).count
  end
end
# rubocop:enable Metrics/ClassLength
