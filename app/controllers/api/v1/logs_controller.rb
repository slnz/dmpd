module Api
  module V1
    class LogsController < ApplicationController
      before_action :authenticate_user!
      respond_to :json

      def index
        load_logs
        decorate_logs
      end

      def show
        load_log
        decorate_log
      end

      def latest
        load_latest_log
        decorate_log
        return if @log
        render json: { error: 'not found' }, status: :not_found
      end

      protected

      def log_scope
        current_user.logs.order('created_at desc')
      end

      def decorate_log
        @log = @log.try(:decorate)
      end

      def load_latest_log
        @log ||=
          log_scope.find_or_create_by(
            start: time.to_date.beginning_of_week,
            finish: (time.to_date + 1.week).beginning_of_week - 1.day)
        @log.try(:fetch_statistics)
      end

      def load_log
        @log ||= log_scope.find(params[:id])
      end

      def load_logs
        @logs ||= log_scope
      end

      def decorate_logs
        @logs = (@logs || load_logs).try(:decorate)
      end

      def time
        Time.now.utc
      end
    end
  end
end
