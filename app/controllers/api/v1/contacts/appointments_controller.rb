module Api
  module V1
    module Contacts
      class AppointmentsController < Api::V1::AppointmentsController
        protected

        def appointment_scope
          current_user.contacts.find(params[:contact_id]).appointments
        end

        def appointment_params
          Params.permit(params)
        end

        class Params
          def self.permit(params)
            return {} unless params[:appointment]
            params.require(:appointment)
              .permit(
                :time, :address, :notes, :result)
          end
        end
      end
    end
  end
end
