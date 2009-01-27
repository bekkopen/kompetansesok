require 'fileutils'

Gitt /^at følgende databasefiler finnes:$/ do |filer|
  Gitt 'at ingen databasefiler finnes'
  filer.rows.each do |fil|
    FileUtils.touch(File.join(Udir::DB_DUMP_PATH, fil))
  end
end

Gitt /^at ingen databasefiler finnes$/ do
  FileUtils.rm_rf(Udir::DB_DUMP_PATH) if File.directory?(Udir::DB_DUMP_PATH)
  FileUtils.mkdir_p(Udir::DB_DUMP_PATH)
end

Så /^skal jeg se følgende liste over databasefiler$/ do |filer|
  filer.rows.each_with_index do |row, n|
    fil = row[0]
    response.should have_selector("#db_liste > li:nth-child(#{n+1}) > a") { |a|
      a.inner_text.should == fil
    }
  end

  response.should_not contain(I18n.t('feilmelding.ingen_db_dump'))
end

Så /^skal jeg ikke se noen databasefiler$/ do
  response.should_not have_selector("#db_liste")
  response.should contain(I18n.t('feilmelding.ingen_db_dump'))
end
