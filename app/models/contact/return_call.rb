class Contact
  class ReturnCall < ActiveRecord::Base
    belongs_to :contact
    enum state:
      [:ask_for_appointment, :for_appointment, :for_decision, :for_contacts]
  end
end
