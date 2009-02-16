require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::ImportDriver do
  before :each do
    @importer_mock = mock(Kompetansesok::Importerer, {:importer_til_fil => true, :importer_til_db => true})
    @db_eksport_mock = mock(Kompetansesok::DbEksport)
    Kompetansesok::RapportMailer.stub!(:send_rapport => true)
    @import_driver = Kompetansesok::ImportDriver.new(
      :importer   => @importer_mock,
      :db_eksport => @db_eksport_mock
    )
  end

  it "should give ok if no error is rased" do
    @import_driver.should_receive(:run_command).and_return(true)
    
    lambda{silence { @import_driver.run } }.should_not raise_error
  end

  it "should give error if file import fails" do
    @importer_mock.should_receive(:importer_til_fil).and_raise("test file error")

    lambda{silence {@import_driver.run } }.should raise_error
  end

  it "should give error if db import fails" do
    @importer_mock.should_receive(:importer_til_db).and_raise("test file error")
    @db_eksport_mock.should_receive(:restore_backup).and_return(true)

    @import_driver.should_receive(:reindexer).and_return(true)

    lambda{ silence{@import_driver.run}  }.should raise_error
  end

  it "should give error if indexing fails" do
    @import_driver.should_receive(:run_command).with("jruby -S rake ultrasphinx:index").and_raise("test index error")

    lambda{silence {@import_driver.run } }.should raise_error
  end

  it "should rollback when db import goes bad, followed by a reindex" do
    @importer_mock.should_receive(:importer_til_db).and_raise("test file error")
    @db_eksport_mock.should_receive(:restore_backup).and_return(true)
    @import_driver.should_receive(:reindexer).and_return(true)

    lambda{
      silence {@import_driver.run}
    }.should raise_error
  end

  it "should give correct email report on succsessfull import" do
    test_report =
      "Laster ned rdf data... ok
Importerer til database.. ok
Reindekserer... ok
Planlagt import og reindexering er velykket\n"
    
    @import_driver.should_receive(:run_command).and_return(true)
    @import_driver.should_receive(:send_rapport).with(test_report).and_return(true)
    lambda{@import_driver.run}.should_not raise_error
  end

  it "should give correct email report importer_til_dbeport on failed db import" do
    test_report =
      "Laster ned rdf data... ok
test file error
Import til database feilet:\n"

    @importer_mock.should_receive(:importer_til_db).and_raise("test file error")
    @db_eksport_mock.should_receive(:restore_backup).and_return(true)
    @import_driver.should_receive(:reindexer).and_return("Gjør reindexering... ok(tekst fra test case)")

    @import_driver.should_receive(:send_rapport).with(test_report).and_return(true)
    lambda{@import_driver.run}.should raise_error
    
  end




  it "should give correct dbdump" do
    tmp_file_name = File.join(Rails.root, "public", "db_dumps", "db_dump_22-01-3000-11:11.zip")

    dirname =File.dirname(tmp_file_name)
    if not File.directory?(dirname)
      Dir.mkdir(dirname)
    end
    
    File.new(tmp_file_name, File::CREAT)
    Kompetansesok::DbEksport.new.find_last_db_dump.should == tmp_file_name
    File.delete(tmp_file_name)
  
  end

  #running the block, returning the output to stdout
  def silence(&block)
    require 'stringio'
    log = StringIO.new
    @old_stdout = $stdout
    $stdout = log
    begin
      yield
    ensure
      $stdout = @old_stdout
    end
  end
end

