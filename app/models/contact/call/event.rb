class Contact
  class Call
    class Event < ActiveRecord::Base
      belongs_to :call
      enum state: Contact::Call.states
      enum step: Contact::Call.steps
      enum transition: Contact.statuses
    end
  end
end
