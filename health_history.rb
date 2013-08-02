
ENV['RACK_ENV'] ||= 'development'

root = File.expand_path(File.dirname(__FILE__))
$: << root
$: << File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'bundler'
Bundler.require

require 'config/environment'

module HealthHistory
  Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each do |f|
    autoload File.basename(f, '.rb').camelize.to_sym, f
  end

  Dir[File.join(File.dirname(__FILE__), 'lib', 'models/*.rb')].each do |f|
    autoload File.basename(f, '.rb').camelize.to_sym, f
  end

  module Helpers
    Dir[File.join(File.dirname(__FILE__), 'lib', 'helpers/*.rb')].each { |f| require f }
  end

  module Controllers
    Dir[File.join(File.dirname(__FILE__), 'lib', 'controllers/*.rb')].each do |f|
      autoload File.basename(f, '.rb').camelize.to_sym, f
    end
  end

  def self.route_map
    map = {
      '/'                => HealthHistory::App,
      '/user'            => HealthHistory::Controllers::UserController
    }
    map
  end
end
