class Contact
  class Appointment < ActiveRecord::Base
    self.table_name = 'dmpd_contact_appointments'
    belongs_to :contact

    enum result: [
      :waiting,
      :support,
      :callback_for_decision,
      :no_support
    ]

    after_save :move_contact

    # rubocop:disable Metrics/MethodLength
    def move_contact
      case result.try(:to_sym)
      when :waiting
        contact.appointment_set!
      when :support
        contact.appointment_new_ministry_partner!
      when :callback_for_decision
        contact.callback_for_decision!
      when :no_support
        contact.appointment_no_support!
      end
      contact.save
    end
    # rubocop:enable Metrics/MethodLength
  end
end
