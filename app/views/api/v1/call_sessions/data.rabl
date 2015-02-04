object false
node(:first_name) { @data[:name] }
node(:count) { pluralize @data[:count], 'call' }