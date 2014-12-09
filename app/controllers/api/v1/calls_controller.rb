# rubocop:disable Metrics/MethodLength, Metrics/ClassLength
module Api
  module V1
    class CallsController < ApplicationController
      before_action :authenticate_user!
      respond_to :json

      def show
        load_call
        decorate_call
        return if @call
        render json: { error: 'not found' }, status: :not_found
      end

      protected

      def call_scope
        current_user.calls
      end

      def decorate_call
        @call = @call.try(:decorate)
      end

      def load_call
        @call ||= call_scope.find_by(end_time: nil)
      end
    end
  end
end
