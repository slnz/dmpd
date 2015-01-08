require "#{Rails.root}/app/models/contact/call"
class Contact
  class Call
    class EventDecorator < ApplicationDecorator
      def start_time
        created_at.to_i
      end

      def step_title
        step.try(:titleize)
      end

      def state_title
        state.try(:titleize)
      end

      def transition_title
        transition.try(:titleize)
      end
    end
  end
end
