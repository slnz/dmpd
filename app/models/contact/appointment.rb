class Contact
  class Appointment < ActiveRecord::Base
    belongs_to :contact
  end
end
