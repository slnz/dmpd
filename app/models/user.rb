class User < StaffPortal
  default_scope { order(:first_name) }
  devise :cas_authenticatable, :trackable
  has_many :contacts
  has_many :call_sessions
end
