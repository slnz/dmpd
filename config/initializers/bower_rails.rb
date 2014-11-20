if Rails.env.development? || Rails.env.test?
  BowerRails.configure do |bower_rails|
    bower_rails.install_before_precompile = true
    bower_rails.resolve_before_precompile = true
    bower_rails.clean_before_precompile = true
    bower_rails.use_bower_install_deployment = true
  end
end
