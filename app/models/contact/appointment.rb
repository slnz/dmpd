class Contact
  class Appointment < ActiveRecord::Base
    belongs_to :contact

    enum result: [
      :waiting,
      :support,
      :support_callback_for_contacts,
      :callback_for_decision,
      :no_support,
      :no_support_callback_for_contacts
    ]

    after_save do
      case result
      when :support
        contact.appointment_new_ministry_partner!
      when :support_callback_for_contacts
        contact.appointment_new_ministry_partner!
        contact.callback_for_contacts!
      when :callback_for_decision
        contact.callback_for_decision!
      when :no_support
        contact.appointment_no_support!
      when :no_support_callback_for_contacts
        contact.appointment_no_support!
        contact.callback_for_contacts!
      end
    end
  end
end
