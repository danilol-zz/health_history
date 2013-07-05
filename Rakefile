require 'bundler/setup'
Bundler.require

Dir[File.join(File.dirname(__FILE__), 'tasks/*')].each { |f| load f }

$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

task :default => [:spec, :cucumber]
