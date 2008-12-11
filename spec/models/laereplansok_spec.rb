require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Laereplansok do
  before :all do 
    importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
    importerer.importer_til_db
  end
  
  before :each do
    @laereplansok = Laereplansok.new
    @laereplansok.instance_variable_set(:@per_page,  100000)
  end
  
  it "should return nothing if there is a no matching laereplantittel" do
    @laereplansok.laereplan_tittel = "asdfasdfasdf"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.should be_empty
  end

  it "should return all records when no search parameters are given" do
    @laereplansok.kompetansemaal.length.should == 67
  end
  
  it "should be possible to search by laereplantittel" do
    @laereplansok.laereplan_tittel = "aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.length.should  == 38
  end
  
  it "should be possible to search by laereplankode" do
    @laereplansok.laereplan_kode = "IDR1-01"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.length.should  == 38
  end
  
  it "should be possible to search by hovedomraadeuuid" do
    pending "søke feil"
    @laereplansok.hovedomraade_uuid = "uuid:78085ca0-5d55-4caa-a3b9-1bf54e720027"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.length.should  == 5
  end
  

end
