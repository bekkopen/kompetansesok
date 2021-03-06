require 'fileutils'

module Udir
  CONFIG = YAML.load_file(File.join(Rails.root, 'config/udir.yml'))

  DB_DUMP_PATH = if Rails.env == 'production'
    CONFIG['db_dumps']['path']
  else
    File.join(Rails.public_path, 'db_dumps')
  end
  
  FileUtils.mkdir_p(DB_DUMP_PATH) unless File.directory?(DB_DUMP_PATH)

  DUMP_COUNT   = CONFIG['db_dumps']['count']

  #Mail konfigurasjon
  mail_config = CONFIG['mail']
  SMTP_SERVER = mail_config['server']
  SMTP_USERNAME = mail_config['username']
  SMTP_PASSWORD = mail_config['password']
  SMTP_PORT = mail_config['server_port']
  DOMAIN = mail_config['domain']

  SEND_MAIL_TIL = mail_config['to']
  SEND_MAIL_FRA = mail_config['from']
  SEND_MAIL_FRA_ALIAS = mail_config['from_alias']
  MAIL_SUBJECT = mail_config['subject']

end