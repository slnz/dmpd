Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    devise_scope :user do
      get 'auth/logout' => 'devise/sessions#destroy'
    end
  end
  root to: 'dashboard#index'
end
