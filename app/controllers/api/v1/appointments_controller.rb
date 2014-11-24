module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :authenticate_user!
      respond_to :json

      def index
        decorate_appointments
      end

      def show
        decorate_appointment
      end

      def create
        build_appointment
        if save_appointment
          decorate_appointment
          render :show
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      def update
        load_appointment
        build_appointment
        if save_appointment
          decorate_appointment
          render :show
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        load_appointment
        @appointment.destroy
        redirect_to appointments_path
      end

      protected

      def load_appointments
        @appointments ||= appointment_scope.order('time desc')
      end

      def decorate_appointments
        @appointments = (@appointments || load_appointments).decorate
      end

      def load_appointment
        @appointment ||= appointment_scope.find(params[:id])
      end

      def build_appointment
        @appointment ||= appointment_scope.build
        @appointment.attributes = appointment_params
      end

      def save_appointment
        @appointment.save
      end

      def decorate_appointment
        @appointment =
          @appointment.try(:decorate) || load_appointment.decorate
      end

      def appointment_scope
        current_user.appointments
      end

      def appointment_params
        Params.permit(params)
      end

      class Params
        def self.permit(params)
          return {} unless params[:appointment]
          params.require(:appointment)
            .permit(
              :time, :address, :notes, :contact_id)
        end
      end
    end
  end
end
