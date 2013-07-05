# -*- encoding : utf-8 -*-
require 'bundler'
Bundler.require

$: << File.dirname(__FILE__)
require 'health_history'

run Rack::URLMap.new HealthHistory.route_map
