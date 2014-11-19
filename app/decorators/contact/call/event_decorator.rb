class Contact
  class Call
    class EventDecorator < ApplicationDecorator
      def start_time
        created_at.to_i
      end
    end
  end
end
