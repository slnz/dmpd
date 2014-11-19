class StaffPortal < ActiveRecord::Base
  self.abstract_class = true
  establish_connection("staffportal_#{Rails.env}".to_sym) unless Rails.env.test?
end
