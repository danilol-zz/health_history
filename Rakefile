require 'bundler/setup'
Bundler.require

Dir[File.join(File.dirname(__FILE__), 'tasks/*')].each { |f| load f }

load 'mongoid_migrations/tasks/migrate.rake'


$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'cucumber/rake/task'

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end
