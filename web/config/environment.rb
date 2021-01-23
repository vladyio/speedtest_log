ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'sinatra'
require 'sinatra/activerecord'
require 'sqlite3'
require 'pry'
require 'time'
require 'date'

set :root, File.join(File.dirname(__FILE__), '..')
set :database, { adapter: 'sqlite3', database: 'speedtest_log.db' }
register Sinatra::ActiveRecordExtension

require_rel '../app'
