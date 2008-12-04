require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe Kompetansesok::Importerer do
  before(:each) do
    @importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
    @jena = mock(Kompetansesok::Jena)
    @jena.stub!(:les_rdf_fil)
    @jena.stub!(:laereplaner)
    @jena.stub!(:kompetansemaalsett)
    Kompetansesok::Jena.stub!(:new).and_return(@jena)
  end

  describe "import of laereplaner" do
    before :each do
      @laereplaner = [{:uuid => "uuid", :tittel => "tittel", :kode => "kode"}]
      @jena.should_receive(:laereplaner).and_return(@laereplaner)
      @importerer.importer_til_db(1)
      @laereplan = Laereplan.find :first
    end

    it "should contain uuid" do
      @laereplan.uuid.should == "uuid"
    end
    
    it "should contain tittel" do
      @laereplan.tittel.should == "tittel"
    end

    it "should contain kode" do
      @laereplan.kode.should == "kode"
    end
  end
  
  describe "import of kompetansemaalsett" do
    before :each do
      @kompetansemaalsett = [{:uuid => "uuid", :tittel => "tittel"}]
      @jena.should_receive(:kompetansemaalsett).and_return(@kompetansemaalsett)
      @importerer.importer_til_db(1)
      @kompetansemaalsett = Kompetansemaalsett.find :first
    end
    
    it "should contain uuid" do
      @kompetansemaalsett.uuid.should == "uuid"
    end
    
    it "should contain tittel" do
      @kompetansemaalsett.tittel.should == "tittel"
    end
  end
end

