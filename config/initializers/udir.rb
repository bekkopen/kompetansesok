require 'fileutils'

module Udir
  CONFIG = YAML.load_file(File.join(Rails.root, 'config/udir.yml'))

  DB_DUMP_PATH = File.join(Rails.public_path, CONFIG['db_dumps']['path'])
  FileUtils.mkdir_p(DB_DUMP_PATH) unless File.directory?(DB_DUMP_PATH)

  DUMP_COUNT   = CONFIG['db_dumps']['count']

  #Mail konfigurasjon
  mail_config = CONFIG['mail']
  SMTP_SERVER = mail_config['server']
  SMTP_USERNAME = mail_config['username']
  SMTP_PASSWORD =mail_config['password']
  SMTP_PORT =mail_config['server_port']

  RAPPORT_EMAILER= mail_config['rapport_mailser']
  KOMPETANSESOK_ADMIN_EMAIL = mail_config['admin_mail']

end