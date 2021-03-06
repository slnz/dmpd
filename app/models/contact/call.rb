class Contact
  class Call < ActiveRecord::Base
    self.table_name = 'dmpd_contact_calls'
    belongs_to :contact
    has_many :events, dependent: :destroy
    before_create :set_reason

    enum reason: Contact.statuses unless instance_methods.include? :reason

    unless instance_methods.include? :state
      enum state: [:not_in, :must_callback, :got_appointment, :no_appointment,
                   :got_contacts, :no_contacts, :got_support, :no_support,
                   :answered, :line_busy, :no_answer, :must_callback_to_talk]
    end
    unless instance_methods.include? :step
      enum step: [:init, :start_call, :new_contact,
                  :must_callback_for_contacts, :must_callback_for_decision,
                  :ask_for_contacts, :appointment, :callback, :support,
                  :not_present, :input_contacts, :stats, :end]
    end

    def set_reason
      self.reason = contact.try(:status)
    end
  end
end
