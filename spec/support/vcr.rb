VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.ignore_localhost = true
end
