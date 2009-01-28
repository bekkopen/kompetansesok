require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::DbEksport do
  
  it "should call mysql when restoring backup" do
    db_eksport = Kompetansesok::DbEksport.new
    db_eksport.should_receive(:find_last_db_dump).and_return("test_last_db_dump.zip")
    db_eksport.should_receive(:unzip_db_dump).and_return("restore_test.sql")
    db_eksport.should_receive(:run_command).with("mysql -uroot kompetansesok_test  < restore_test.sql").and_return(true)
        
    db_eksport.restore_backup
  end
end

