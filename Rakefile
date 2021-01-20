require 'sinatra/activerecord/rake'

SCHEMA_PATH = 'web/db/schema.rb'.freeze
ENV['SCHEMA'] = SCHEMA_PATH

namespace :db do
  task :load_config do
    require_relative './web/config/environment'
  end

  task :create_with_schema do
    Rake::Task["db:create"].invoke
    Rake::Task["db:schema:load"].invoke
  end
end
