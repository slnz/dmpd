collection :@contacts
attributes :id, :name, :primary_phone,
  :priority_code, :status_title, :category, :last_called
child(:return_call, if: lambda { |contact| contact.return_call }) do
  attributes :time
end
node(:total) {|m| @contacts.total_count }
node(:pinned) {|m| false }