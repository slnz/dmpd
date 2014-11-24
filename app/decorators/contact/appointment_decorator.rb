class Contact
  class AppointmentDecorator < ApplicationDecorator
    decorates_association :contact
    def contact_name
      object.contact.try(:decorate).try(:name)
    end
  end
end
