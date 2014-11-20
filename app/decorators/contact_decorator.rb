class ContactDecorator < ApplicationDecorator
  def first_name
    object.first_name.titleize.strip
  end

  def last_name
    object.last_name.titleize.strip
  end

  def status_title
    status.to_s.split('_').drop(1).join(' ').titleize
  end

  def referer_name
    object.referer.try(:decorate).try(:name)
  end

  def name
    "#{first_name} #{last_name}".titleize
  end

  def return_call
    object.return_calls.last
  end

  def last_called
    object.calls.last.try(:created_at)
  end
end
