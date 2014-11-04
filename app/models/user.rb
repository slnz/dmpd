class User < ActiveRecord::Base
  devise :cas_authenticatable, :trackable
  establish_connection "staffportal_#{Rails.env}".to_sym
end
