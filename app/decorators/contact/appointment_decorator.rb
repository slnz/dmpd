class Contact
  class AppointmentDecorator < ApplicationDecorator
    decorates_association :contact
    def contact_name
      object.contact.try(:decorate).try(:name)
    end

    def contact_status
      object.contact.try(:status)
    end
  end
end
