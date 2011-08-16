require File.expand_path('../boot', __FILE__)
require 'pp'

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"

Bundler.require *Rails.groups(:assets) if defined?(Bundler)

module Feast
  class Application < Rails::Application
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
    config.action_dispatch.x_sendfile_header = nil # for heroku
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    # config.autoload_paths += %W(#{config.root}/extras)
  end
end
