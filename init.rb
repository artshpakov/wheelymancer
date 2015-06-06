require 'rubygems'

RACK_ENV = ENV['RACK_ENV'] || 'development' unless defined? RACK_ENV

require 'bundler'
Bundler.require(:default, RACK_ENV)

Mongoid.load!("config/mongoid.yml", RACK_ENV)

Dir["./app/**/*.rb"].each { |file| require file }
