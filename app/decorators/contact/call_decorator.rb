class Contact
  class CallDecorator < ApplicationDecorator
    decorates_association :events
  end
end
