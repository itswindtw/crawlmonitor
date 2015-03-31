# Database
require 'yaml'
require 'sequel'
db_config = ENV['DATABASE_URL']
db_config ||= YAML.load_file(File.join(BASE_PATH, 'config/database.yml'))[RACK_ENV]
DB = Sequel.connect(db_config)

Sequel.extension :migration
Sequel::Model.plugin :json_serializer
