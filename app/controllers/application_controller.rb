class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: (lambda do
    render json: { error: 'not found' }.to_json, status: 404
  end)
end
