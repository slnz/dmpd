class CallSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner, class_name: 'User'
  validates :user, presence: true

  def end_session
    update end_time: Time.now
  end
end
