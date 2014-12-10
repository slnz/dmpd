# rubocop:disable Metrics/MethodLength, Metrics/ClassLength
module Api
  module V1
    class CallsController < ApplicationController
      before_action :authenticate_user!
      respond_to :json

      def index
        load_calls
        decorate_calls
      end

      def show
        load_call
        decorate_call
      end

      def latest
        load_latest_call
        decorate_call
        return if @call
        render json: { error: 'not found' }, status: :not_found
      end

      def destroy
        load_call
        @call.destroy
        decorate_call
        render :show
      end

      protected

      def call_scope
        current_user.calls
      end

      def decorate_call
        @call = @call.try(:decorate)
      end

      def load_latest_call
        @call ||= call_scope.find_by(end_time: nil)
      end

      def load_call
        @call ||= call_scope.find(params[:id])
      end

      def load_calls
        @calls ||= call_scope.order('created_at desc')
        return unless params[:contact_id]
        @calls = @calls.where(contact_id: params[:contact_id])
      end

      def decorate_calls
        @calls = (@calls || load_calls).try(:decorate)
      end
    end
  end
end
