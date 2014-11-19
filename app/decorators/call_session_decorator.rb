class CallSessionDecorator < ApplicationDecorator
  def start_time
    created_at.to_i
  end

  def partner_name
    partner.try(:first_name).try(:titleize)
  end
end
