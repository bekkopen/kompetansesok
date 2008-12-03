# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe Kompetansesok::Importerer do
  before(:each) do
    @importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
  end

  describe "import of laereplaner" do
    before :each do
      @importerer.importer_til_db(1)
      @laereplan = Laereplan.find :first
    end

    it "should contain tittel" do
      @laereplan.tittel.should == "Læreplan i aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"
    end

    it "should contain uuid" do
      @laereplan.uuid.should == "uuid:9bdc529c-09f8-4eda-8c6e-fefe950daac7"
    end

    it "should contain kode" do
      @laereplan.kode.should == "IDR1-01"
    end
  end
end

