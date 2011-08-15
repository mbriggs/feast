require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.before(:each) do
      Mongoid.master.collections.reject {|c| c.name =~ /system/ }.each(&:drop)
    end
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb" 
  Dir[Rails.root.join("spec/support/**/*.rb")].each &method(:load)
  Dir["#{Rails.root}/app/**/*.rb"].each &method(:load)
  Dir["#{Rails.root}/lib/**/*.rb"].each &method(:load)
end

