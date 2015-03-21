require 'yaml'

# Database
require 'sequel'
db_config = YAML.load_file(File.join(BASE_PATH, 'config/database.yml'))[RACK_ENV]
DB = Sequel.connect(db_config)

Sequel.extension :migration
