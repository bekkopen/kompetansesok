cd %~dp0..\..
call jruby -S rake import:scheduled_import_win RAILS_ENV=production