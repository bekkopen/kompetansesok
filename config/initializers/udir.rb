module Udir
  CONFIG = YAML.load_file(File.join(Rails.root, 'config/udir.yml'))
  
  DB_DUMP_PATH = File.join(Rails.public_path, CONFIG['db_dumps']['path'])
end