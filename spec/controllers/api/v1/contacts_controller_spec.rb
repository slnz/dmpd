require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  before do
    @user ||= create :user
    sign_in @user
  end
  let(:contact) { create(:contact, user: @user) }
  it { should use_before_action(:authenticate_user!) }

  describe '#index' do
    before { get :index }
    it { expect(assigns(:contacts)).to be_decorated }
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template :index }
  end

  describe '#show' do
    context 'when contact is found' do
      before { get :show, id: contact }
      it { expect(assigns(:contact)).to be_decorated }
      it { expect(assigns(:contact)).to eq(contact) }
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template :show }
    end
    context 'when contact is not found' do
      before { get :show, id: -1 }
      it { is_expected.to respond_with 404 }
      it { expect(json_response['error']).to eq('not found') }
    end
  end

  describe '#create' do
    context 'when new contact is valid' do
      before { post :create, contact: attributes_for(:contact) }
      it { expect(assigns(:contact)).to be_valid }
      it { expect(assigns(:contact)).to be_persisted }
      it { expect(assigns(:contact)).to be_decorated }
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template :show }
    end
    context 'when new contact is invalid' do
      before do
        post :create,
             contact: attributes_for(:contact, first_name: nil)
      end
      it { expect(assigns(:contact)).to_not be_valid }
      it { expect(assigns(:contact)).to_not be_persisted }
      it { is_expected.to respond_with 422 }
      it { expect(json_response['first_name']).to eq(["can't be blank"]) }
    end
  end

  describe '#update' do
    context 'when contact is found' do
      context 'when contact update is valid' do
        before { put :update, id: contact, contact: attributes_for(:contact) }
        it { expect(assigns(:contact)).to be_valid }
        it { expect(assigns(:contact)).to be_persisted }
        it { expect(assigns(:contact)).to be_decorated }
        it { is_expected.to respond_with 200 }
        it { is_expected.to render_template :show }
      end
      context 'when contact update is invalid' do
        before do
          put :update,
              id: contact,
              contact: attributes_for(:contact, first_name: nil)
        end
        it { expect(assigns(:contact)).to_not be_valid }
        it { is_expected.to respond_with 422 }
        it { expect(json_response['first_name']).to eq(["can't be blank"]) }
      end
    end
    context 'when contact is not found' do
      before { put :update, id: -1 }
      it { is_expected.to respond_with 404 }
      it { expect(json_response['error']).to eq('not found') }
    end
  end

  describe '#destroy' do
    context 'when contact is found' do
      before { delete :destroy, id: contact }
      it { expect(assigns(:contact)).to be_decorated }
      it { expect(assigns(:contact)).to_not be_persisted }
      it { is_expected.to render_template :show }
      it { is_expected.to respond_with 200 }
    end
    context 'when contact is not found' do
      before { delete :destroy, id: -1 }
      it { is_expected.to respond_with 404 }
      it { expect(json_response['error']).to eq('not found') }
    end
  end
end
