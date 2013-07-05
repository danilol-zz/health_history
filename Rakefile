require 'bundler/setup'
Bundler.require

Dir[File.join(File.dirname(__FILE__), 'tasks/*')].each { |f| load f }

load 'mongoid_migrations/tasks/migrate.rake'
