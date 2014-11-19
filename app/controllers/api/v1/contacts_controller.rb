module Api
  module V1
    class ContactsController < ApplicationController
      before_action :authenticate_user!
      respond_to :json

      Contact.statuses.keys.each do |category|
        has_scope category.to_sym, type: :boolean
      end

      has_scope :calls, type: :boolean

      def index
        decorate_contacts
      end

      def show
        decorate_contact
      end

      def create
        build_contact
        if save_contact
          decorate_contact
          render :show
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      def update
        load_contact
        build_contact
        if save_contact
          decorate_contact
          render :show
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      def destroy
        load_contact
        @contact.destroy
        decorate_contact
        render :show
      end

      def status(statuses = [])
        count = contact_scope.group(:status).count
        massage_statuses(statuses, count)
        statuses.push(
          name: 'all', data: [{ name: 'All Contacts', count: count.values.sum }]
        )
        render json: statuses.to_json
      end

      protected

      def massage_statuses(statuses = {}, count)
        Contact.statuses.invert.each do |key, value|
          split_value = value.split('_')
          category = Contact.categories[split_value[0]]
          statuses[category] ||= { name: split_value[0], data: [] }
          statuses[category][:data].push(
            name: split_value.drop(1).join(' ').titleize,
            param: value,
            count: count[key].to_i)
        end
      end

      def load_contacts
        @q ||= apply_scopes(contact_scope).search(params[:q])
        @contacts ||=
          @q.result(distinct: true).page(params[:page]).per(params[:limit])
      end

      def decorate_contacts
        @contacts = (@contacts || load_contacts).decorate
      end

      def load_contact
        @contact ||= contact_scope.find(params[:id])
      end

      def build_contact
        @contact ||= contact_scope.build
        @contact.attributes = contact_params
      end

      def save_contact
        @contact.save
      end

      def decorate_contact
        @contact = @contact.try(:decorate) || load_contact.decorate
      end

      def contact_scope
        current_user.contacts
      end

      def contact_params
        Params.permit(params)
      end

      class Params
        def self.permit(params)
          return {} unless params[:contact]
          params.require(:contact)
            .permit(
              :first_name, :last_name, :priority_code, :new_church,
              :email, :address, :primary_phone, :home_phone, :office_phone,
              :how_knows, :occupation, :church, :children, :anniversary,
              :status)
        end
      end
    end
  end
end
