object :@contact
attributes :id, :name, :first_name, :last_name, :priority_code, :email, :status,
  :primary_phone, :home_phone, :office_phone, :address, :referer_id, :referer_name,
  :how_knows, :occupation, :church, :new_church, :children, :anniversary,
  :status_title, :notes, :frequency, :amount, :gift_date, :thanks, :category,
  :last_called, :status_full_title
child(:return_call, if: lambda { |contact| contact.return_call }) do
  attributes :time
end