require 'fileutils'

module Udir
  CONFIG = YAML.load_file(File.join(Rails.root, 'config/udir.yml'))

  DB_DUMP_PATH = File.join(Rails.public_path, CONFIG['db_dumps']['path'])
  FileUtils.mkdir_p(DB_DUMP_PATH) unless File.directory?(DB_DUMP_PATH)

  DUMP_COUNT   = CONFIG['db_dumps']['count']

  #Mail konfigurasjon
  SMTP_SERVER = "server"
  SMTP_USERNAME = "user"
  SMTP_PASSWORD ="pass"

  RAPPORT_EMAILER= "aslakjo@bekk.no;aslakjo@ifi.uio.no"
  KOMPETANSESOK_ADMIN_EMAIL = ""

end