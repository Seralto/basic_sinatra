# Require all gems in Gemfile
require 'bundler'
Bundler.require

require './app'
require './lib/people'
# require_relative './lib/people' # or ruby -Ilib app.rb

# Set DataMapper
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

run App
