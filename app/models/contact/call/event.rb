class Contact
  class Call
    class Event < ActiveRecord::Base
      self.table_name = 'dmpd_contact_call_events'
      belongs_to :call
      enum state: Contact::Call.states
      enum step: Contact::Call.steps
      enum transition: Contact.statuses
      validates :step, uniqueness: { scope: :call_id }
    end
  end
end
