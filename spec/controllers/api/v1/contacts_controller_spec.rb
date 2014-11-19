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
    it { expect(assigns(:contacts).first).to eq(@contact) }
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template :index }
  end

  describe '#show' do
    context 'when contact is found' do
      before { get :show, id: contact }
      it { expect(assigns(:contact)).to be_decorated }
      it { expect(assigns(:contact)).to eq(@contact) }
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template :show }
    end
    context 'when contact is not found' do
      before { get :show, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end

  describe '#new' do
    before { get :new }
    it { expect(assigns(:contact)).to be_decorated }
    it { expect(assigns(:contact)).to_not be_persisted }
    it { is_expected.to render_template :new }
    it { is_expected.to respond_with 200 }
  end

  describe '#create' do
    context 'when new contact is valid' do
      before { post :create, contact: attributes_for(:contact) }
      it { expect(assigns(:contact)).to be_valid }
      it { expect(assigns(:contact)).to be_persisted }
      it { is_expected.to redirect_to(contact_path assigns(:contact)) }
      it { is_expected.to respond_with 302 }
      it { is_expected.to set_the_flash[:success] }
    end
    context 'when new contact is invalid' do
      before { post :create, contact: attributes_for(:contact, title: nil) }
      it { expect(assigns(:contact)).to be_decorated }
      it { expect(assigns(:contact)).to_not be_valid }
      it { expect(assigns(:contact)).to_not be_persisted }
      it { is_expected.to render_template :new }
      it { is_expected.to respond_with 200 }
      it { is_expected.to set_the_flash[:error].now }
    end
  end

  describe '#edit' do
    context 'when contact is found' do
      before { get :edit, id: contact }
      it { expect(assigns(:contact)).to be_decorated }
      it { expect(assigns(:contact)).to eq(@contact) }
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template :edit }
    end
    context 'when contact is not found' do
      before { get :show, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end

  describe '#update' do
    context 'when contact is found' do
      context 'when contact update is valid' do
        before { put :update, id: contact, contact: attributes_for(:contact) }
        it { expect(assigns(:contact)).to be_valid }
        it { expect(assigns(:contact)).to be_persisted }
        it { is_expected.to redirect_to(contact_path assigns(:contact)) }
        it { is_expected.to respond_with 302 }
        it { is_expected.to set_the_flash[:success] }
      end
      context 'when contact update is invalid' do
        before do
          put :update,
              id: contact,
              contact: attributes_for(:contact, title: nil)
        end
        it { expect(assigns(:contact)).to_not be_valid }
        it { expect(assigns(:contact)).to be_decorated }
        it { is_expected.to render_template :edit }
        it { is_expected.to respond_with 200 }
        it { is_expected.to set_the_flash[:error].now }
      end
    end
    context 'when contact is not found' do
      before { put :update, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end

  describe '#destroy' do
    context 'when contact is found' do
      before { delete :destroy, id: contact }
      it { expect(assigns(:contact)).to_not be_persisted }
      it { is_expected.to redirect_to(contacts_path) }
      it { is_expected.to respond_with 302 }
      it { is_expected.to set_the_flash[:info] }
    end
    context 'when contact is not found' do
      before { delete :destroy, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end
end
