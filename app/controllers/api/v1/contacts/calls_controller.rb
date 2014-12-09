# rubocop:disable Metrics/MethodLength, Metrics/ClassLength
module Api
  module V1
    module Contacts
      class CallsController < ApplicationController
        before_action :authenticate_user!
        respond_to :json

        def show
          load_state
          load_call
          load_step
          send @step
          save_call
          decorate_call
        rescue ActionController::RoutingError => e
          render json: { error: e.message }, status: :not_found
        end

        def fetch
          load_call
          init unless @call
          end_call if @call && @call.step == 'end'
          decorate_call
          render :fetch
        end

        def destroy
          load_call_by_id
          @call.destroy
          render :show
        end

        private

        def steps
          Contact::Call.steps
        end

        def states
          Contact::Call.states
        end

        def load_call
          @call ||= call_scope.find_by(end_time: nil)
          return unless !@call && params[:step] == 'init'
          fail ActionController::RoutingError, 'need to init call (init)'
        end

        def load_call_by_id
          @call ||= call_scope.find(params[:id])
        end

        def load_state
          unless states.include?(params[:state]) || !params[:state]
            fail ActionController::RoutingError, 'state not found'
          end
          @state ||= params[:state].try(:to_sym)
        end

        def decorate_call
          @call = @call.try(:decorate)
        end

        def build_call
          @call ||= call_scope.build
          @call.attributes = call_params
        end

        def save_call
          @call.save
        end

        def call_scope
          load_contact.calls
        end

        def load_contact
          @contact ||= contact_scope.find(params[:contact_id])
        end

        def contact_scope
          current_user.contacts
        end

        def load_step
          unless steps.include?(params[:id])
            fail ActionController::RoutingError, 'step not found'
          end
          @step ||= params[:id]
        end

        def jump_to(step, log = true)
          unless steps.include?(step)
            fail ActionController::RoutingError, 'jump_step not found'
          end
          @call.events.create(
            step: step,
            state: @state,
            message: @message,
            transition: @transition
          ) if log
          @step = step
          @contact.send "#{@transition}!" if @transition
          @call.send "#{@step}!"
          end_call if step == :end
        end

        def init
          build_call
          save_call
          @message = 'Dialing'
          jump_to :start_call
        end

        def start_call
          case @state
          when :answered
            @message = 'Answered the phone'
            case @contact.status
            when 'callback_for_contacts'
              jump_to :must_callback_for_contacts
            when 'callback_for_decision'
              jump_to :must_callback_for_decision
            else
              jump_to :new_contact
            end
          when :line_busy
            @message = 'Line Busy'
            jump_to :not_present
          when :no_answer
            @message = 'No Answer'
            jump_to :not_present
          else
            @possible_states = [:answered, :line_busy, :no_answer]
          end
        end

        def new_contact
          case @state
          when :not_in
            @message = 'Not in'
            jump_to :not_present
          when :must_callback_to_talk
            @message = 'Not a good time to talk'
            jump_to :callback
          when :must_callback
            @message = 'Interested in meeting but callback to schedule'
            @transition = :callback_for_appointment
            jump_to :callback
          when :got_appointment
            @message = 'Interested in meeting'
            @transition = :appointment_set
            jump_to :appointment
          when :no_appointment
            @message = 'Not interested in meeting'
            @transition = :appointment_none
            jump_to :ask_for_contacts
          else
            @possible_states =
              [:not_in, :must_callback_to_talk,
               :must_callback, :got_appointment, :no_appointment]
          end
        end

        def must_callback_for_contacts
          case @state
          when :not_in
            @message = 'Not in'
            jump_to :not_present
          when :must_callback_to_talk
            @message = 'Not a good time to talk'
            jump_to :callback
          when :must_callback
            @message = 'Must callback for contacts'
            jump_to :callback
          when :got_contacts
            @message = 'Interested in giving contacts'
            jump_to :input_contacts
          when :no_contacts
            @message = 'Not interested in giving contacts'
            jump_to :stats
          else
            @possible_states =
              [:not_in, :must_callback_to_talk,
               :must_callback, :got_contacts, :no_contacts]
          end
        end

        def must_callback_for_decision
          case @state
          when :not_in
            @message = 'Not in'
            jump_to :not_present
          when :must_callback_to_talk
            @message = 'Not a good time to talk'
            jump_to :callback
          when :must_callback
            @message = 'Must callback for decision'
            jump_to :callback
          when :got_support
            @message = 'Interested in supporting'
            @transition = :appointment_new_ministry_partner
            jump_to :support
          when :no_support
            @message = 'Not Interested in supporting'
            @transition = :appointment_no_support
            jump_to :stats
          else
            @possible_states =
              [:not_in, :must_callback_to_talk,
               :must_callback, :got_support, :no_support]
          end
        end

        def ask_for_contacts
          case @state
          when :got_contacts
            @message = 'Interested in giving contacts'
            jump_to :input_contacts
          when :no_contacts
            @message = 'Not interested in giving contacts'
            jump_to :stats
          when :must_callback_to_talk
            @message = 'Not a good time to talk'
            jump_to :callback
          when :must_callback
            @message = 'Must callback for contacts'
            jump_to :callback
          else
            @possible_states =
              [:got_contacts, :must_callback_to_talk,
               :no_contacts, :must_callback]
          end
        end

        def input_contacts
          @message = 'Completed entering contacts'
          jump_to :stats
        end

        def appointment
          @message = 'Completed entering appointment'
          jump_to :stats
        end

        def callback
          @message = 'Completed entering callback'
          jump_to :stats
        end

        def support
          @message = 'Completed entering support'
          jump_to :stats
        end

        def not_present
          jump_to :stats, false
        end

        def stats
          @message = 'Concluded call'
          jump_to :end
        end

        def end_call
          @call.end_time = Time.now
          save_call
        end

        def call_params
          Params.permit(params)
        end

        class Params
          def self.permit(params)
            return {} unless params[:call]
            params.require(:call).permit
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength, Metrics/ClassLength
