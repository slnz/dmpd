object false
node(:first_name) { @data[:name] }
node(:count) { pluralize @data[:count], 'call' }
node(:partners) do
  @data[:partners].map do |partner|
    { id: partner.id, name: partner.name }
  end
end