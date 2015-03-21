RACK_ENV = ENV['RACK_ENV'] || 'development'
BASE_PATH = File.expand_path('../..', __FILE__)

require 'bundler'
Bundler.setup(:default, RACK_ENV)

$LOAD_PATH << File.join(BASE_PATH, 'app')
$LOAD_PATH << File.join(BASE_PATH, 'lib')

puts "Initializing API service in #{RACK_ENV} mode"
