class UserDecorator < ApplicationDecorator
  def name
    "#{first_name.try(:titleize)} #{last_name.try(:titleize)}".strip
  end
end
