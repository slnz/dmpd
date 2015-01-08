Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    devise_scope :user do
      get 'auth/logout' => 'devise/sessions#destroy'
    end
  end
  root to: 'dashboard#index'

  namespace :api do
    api_version(
      module: 'V1',
      header: {
        name: 'Accept',
        value: 'application/dmpd.staffportal.org; version=1' },
      parameter: { name: 'version', value: '1' },
      path: { value: 'v1' }) do
      resources :calls, only: [:index, :show, :destroy] do
        collection do
          get 'latest'
        end
      end
      resources :contacts do
        collection do
          get 'status'
        end
        scope module: :contacts do
          resources :calls, except: [:create] do
            collection do
              get 'fetch'
            end
          end
          resources :appointments
          resources :return_calls
        end
      end
      resource :call_session do
        member do
          get 'data'
        end
      end
      resources :appointments
      resources :logs, only: [:index, :show, :destroy] do
        collection do
          get 'latest'
        end
      end
    end
  end

  match "*path", to: 'dashboard#index', via: :all
end
