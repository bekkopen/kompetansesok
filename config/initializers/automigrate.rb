if Rails.env == 'production'
  # Migrer automatisk hvis vi er i prod
  migrations = File.expand_path(File.dirname(__FILE__) + '/../../db/migrate/')
  ActiveRecord::Migrator.migrate(migrations)
end