module Api
  module V1
    module Contacts
      class ReturnCallsController < ApplicationController
        before_action :authenticate_user!
        respond_to :json

        def index
          decorate_return_calls
        end

        def show
          decorate_return_call
        end

        def create
          build_return_call
          if save_return_call
            decorate_return_call
            render :show
          else
            render json: @return_call.errors, status: :unprocessable_entity
          end
        end

        def update
          load_return_call
          build_return_call
          if save_return_call
            decorate_return_call
            render :show
          else
            render json: @return_call.errors, status: :unprocessable_entity
          end
        end

        def destroy
          load_return_call
          @return_call.destroy
          redirect_to return_calls_path
        end

        protected

        def load_return_calls
          @return_calls ||= return_call_scope
        end

        def decorate_return_calls
          @return_calls = (@return_calls || load_return_calls).decorate
        end

        def load_return_call
          @return_call ||= return_call_scope.find(params[:id])
        end

        def build_return_call
          @return_call ||= return_call_scope.build
          @return_call.attributes = return_call_params
        end

        def save_return_call
          @return_call.save
        end

        def decorate_return_call
          @return_call =
            @return_call.try(:decorate) || load_return_call.decorate
        end

        def return_call_scope
          current_user.contacts.find(params[:contact_id]).return_calls
        end

        def return_call_params
          Params.permit(params)
        end

        class Params
          def self.permit(params)
            return {} unless params[:return_call]
            params.require(:return_call)
              .permit(
                :time, :notes)
          end
        end
      end
    end
  end
end
