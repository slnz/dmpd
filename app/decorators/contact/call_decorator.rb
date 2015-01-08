class Contact
  class CallDecorator < ApplicationDecorator
    decorates_association :events
    decorates_association :contact

    def contact_name
      contact.try(:name)
    end

    def reason_title
      reason.to_s.titleize
    end

    def length
      (end_time - created_at) / 60 / 60
    end
  end
end
