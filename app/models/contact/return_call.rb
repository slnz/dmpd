class Contact
  class ReturnCall < ActiveRecord::Base
    belongs_to :contact
    enum state: [:not_back_until, :for_appointment, :for_contacts]
  end
end
