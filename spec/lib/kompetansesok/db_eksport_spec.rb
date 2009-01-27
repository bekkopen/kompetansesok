require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::DbEksport do
  
  it "should call mysql when restoring backup" do
    mock_db_eksport = mock(Kompetansesok::DbEksport)
    mock_db_eksport.should_receive(:run_command).with("mysql -uroot kompetansesok_test  < /media/data/Projects/kompetansesok/tmp/restore.sql").and_return(true)
        
    Kompetansesok::DbEksport.should_receive(:new).and_return(mock_db_eksport)
    
    Kompetansesok::DbEksport.restore_backup
  end
end

