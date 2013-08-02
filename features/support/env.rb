# -*- encoding : utf-8 -*-
require 'bundler'
Bundler.require :default, :test

require File.expand_path(File.dirname(__FILE__) + '/../../health_history.rb')

require 'rspec'
require 'rack/test'
require "capybara"
require "capybara/cucumber"

require "factory_girl"
require File.expand_path(File.dirname(__FILE__) + '/../../spec/factories.rb')
require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner[:mongoid].strategy = :truncation

Before do
    DatabaseCleaner.start
end

After('@database_reconnect') do
    ActiveRecord::Base.connection.reconnect!
end

After('~@database_reconnect') do
    DatabaseCleaner.clean
end

class HealthHistoryWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Rack::Test::Methods

  Capybara.app = HealthHistory::App

  include Capybara::DSL

  def app
    Rack::URLMap.new HealthHistory.route_map
  end
end

World do
  HealthHistoryWorld.new
end

