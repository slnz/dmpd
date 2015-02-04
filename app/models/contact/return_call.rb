class Contact
  class ReturnCall < ActiveRecord::Base
    self.table_name = 'dmpd_contact_return_calls'
    belongs_to :contact
    enum state:
      [:ask_for_appointment, :for_appointment, :for_decision, :for_contacts]
  end
end
