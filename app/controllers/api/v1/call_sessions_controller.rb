module Api
  module V1
    class CallSessionsController < ApplicationController
      before_action :authenticate_user!
      respond_to :json

      def show
        decorate_call_session
        fail ActiveRecord::RecordNotFound if @call_session.nil?
      end

      def create
        load_call_session
        build_call_session
        save_call_session
        decorate_call_session
        render action: :show
      end

      def data
        call_session_data
      end

      def destroy
        load_call_session
        fail ActiveRecord::RecordNotFound if @call_session.nil?
        @call_session.update end_time: Time.now
        decorate_call_session
        render action: :show
      end

      protected

      def load_call_session
        @call_session ||= call_session_scope.find_by(end_time: nil)
      end

      def build_call_session
        @call_session ||= call_session_scope.build
        @call_session.attributes = call_session_params
      end

      def save_call_session
        @call_session.save
      end

      def decorate_call_session
        @call_session =
          @call_session.try(:decorate) || load_call_session.try(:decorate)
      end

      def call_session_scope
        current_user.call_sessions
      end

      def call_session_params
        Params.permit(params)
      end

      def call_session_data
        @data = { name: current_user.first_name, count: call_count }
      end

      def call_count
        current_user.contacts.calls.count
      end

      class Params
        def self.permit(params)
          return {} unless params[:call_session] && params[:call_session] != {}
          params.require(:call_session).permit(:partner_id)
        end
      end
    end
  end
end
