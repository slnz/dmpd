class User < ActiveRecord::Base
  default_scope { order(:first_name) }
  devise :cas_authenticatable, :trackable
  has_many :contacts, dependent: :destroy
  has_many :calls, through: :contacts, class_name: 'Contact::Call'
  has_many :events, through: :calls, class_name: 'Contact::Call::Event'
  has_many :appointments,
           through: :contacts,
           class_name: '::Contact::Appointment'
  has_many :call_sessions
  has_many :logs
end
