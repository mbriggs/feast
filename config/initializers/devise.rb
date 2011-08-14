require 'openid/store/filesystem'

Devise.setup do |config|
  config.mailer_sender = "feast@nulogy.com"

  require 'devise/orm/active_record'

  config.stretches = 10
  config.pepper = "bbf492a972f62275c16b66e4bd312c8a6b56715336b013af90e8f6b770dd5c23edde8c2e76323d299513dd82388570a72762d7ca021cfc24ebf2e7afa294ca43"
  config.sign_out_via = :delete
  config.omniauth :google_apps, OpenID::Store::Filesystem.new('./tmp'), :domain => 'nulogy.com'
end
