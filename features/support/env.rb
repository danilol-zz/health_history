# -*- encoding : utf-8 -*-
require 'bundler'
Bundler.require :default, :test

require File.expand_path(File.dirname(__FILE__) + '/../../health_history.rb')

require 'rspec'
require 'rack/test'

class HealthHistoryWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Rack::Test::Methods

  def app
    Rack::URLMap.new HealthHistory.route_map
  end
end

World do
  HealthHistoryWorld.new
end

