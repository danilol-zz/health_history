
ENV['RACK_ENV'] ||= 'development'

$: << 'lib'

require 'bundler'
Bundler.require

#require 'config/environment'

module HealthHistory
  Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each do |f|
    autoload File.basename(f, '.rb').camelize.to_sym, f
  end

  Dir[File.join(File.dirname(__FILE__), 'lib', 'models/*.rb')].each do |f|
    autoload File.basename(f, '.rb').camelize.to_sym, f
  end

  module Controllers
    Dir[File.join(File.dirname(__FILE__), 'lib', 'controllers/*.rb')].each do |f|
      autoload File.basename(f, '.rb').camelize.to_sym, f
    end
  end

  def self.route_map
    map = {
      '/'                => HealthHistory::App,
      '/user'            => HealthHistory::Controllers::User
    }
    map
  end
end
