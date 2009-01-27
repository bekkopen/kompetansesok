require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::CsvGenerator do
  before(:each) do
    @generator = Kompetansesok::CsvGenerator.new
  end
  
  it "should find kompetansemaal from a list of uuids" do
    uuids = 'uuid-1, uuid-2'
    Kompetansemaal.should_receive(:find_by_uuid).with('uuid-1').and_return(Kompetansemaal.new)
    Kompetansemaal.should_receive(:find_by_uuid).with('uuid-2').and_return(Kompetansemaal.new)
    
    @generator.rows_for(uuids)
  end
  
  describe "rows" do
    before :each do
      @maal = Kompetansemaal.new(:uuid => 'maal_uuid')
      Kompetansemaal.should_receive(:find_by_uuid).with('maal_uuid').and_return(@maal)
    end
    
    it "should have kompetansemaal.uuid at index 0" do
      rows = @generator.rows_for('maal_uuid')
      rows.first[0].should == 'maal_uuid'
    end
    
    it "should have kompetansemaal.kode at index 1" do
      @maal.kode = 'maal_kode'
      rows = @generator.rows_for('maal_uuid')
      rows.first[1].should == 'maal_kode'
    end
    
    it "should have kompetansemaal.tittel at index 2" do
      @maal.tittel = 'maal_tittel'
      rows = @generator.rows_for('maal_uuid')
      rows.first[2].should == 'maal_tittel'
    end

  end

end

