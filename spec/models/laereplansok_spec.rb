require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Laereplansok do
  before :all do 
    importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
    importerer.importer_til_db
  end

  it "should return a list of kompetansemaal when a valid search query is entered" do
    @laereplansok = Laereplansok.new :laereplan_tittel => "aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"
    kompetansemaal = @laereplansok.kompetansemaal
    puts kompetansemaal.length
    kompetansemaal.length.should  == 38
  end

  it "should return nothing if there is a no matching laereplantittel" do
    @laereplansok = Laereplansok.new :laereplan_tittel => "asdfasdfasdf"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.should be_empty
  end

  it "should return all records when a empty search string is used" do
    @laereplansok = Laereplansok.new :laereplan_tittel => ""
    @laereplansok.kompetansemaal.length.should == 67
  end

end
