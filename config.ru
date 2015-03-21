require_relative 'config/environment'
require_relative 'config/application'

Sequel::Migrator.check_current(DB, File.join(BASE_PATH, 'db/migrations'))

require 'api/base'

use Rack::CommonLogger, Logger.new(File.join(BASE_PATH, "log/#{RACK_ENV}.log"))

run API::Base
