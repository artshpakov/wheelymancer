require 'rubygems'
require 'bundler'
Bundler.require(:default)

RACK_ENV = ENV['RACK_ENV'] || 'development' unless defined? RACK_ENV

Dir["./app/**/*.rb"].each { |file| require file }
