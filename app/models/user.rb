class User < ActiveRecord::Base
  default_scope { order(:first_name) }
  devise :cas_authenticatable, :trackable
  has_many :contacts, dependent: :destroy
  has_many :appointments,
           through: :contacts,
           class_name: '::Contact::Appointment'
  has_many :call_sessions
end
