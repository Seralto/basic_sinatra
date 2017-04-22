# Require all gems in Gemfile
require 'bundler'
Bundler.require

require './app'
require './lib/people'

# Set DataMapper
# DataMapper.setup(:default, 'sqlite::memory:')
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")
DataMapper.finalize.auto_upgrade!

run App
