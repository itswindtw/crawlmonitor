require_relative 'config/environment'
require_relative 'config/application'

Sequel::Migrator.check_current(DB, File.join(BASE_PATH, 'db/migrations'))

require 'api/base'

run API::Base
