require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe Kompetansesok::Importerer do
  before(:each) do
    @importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
    @jena = mock(Kompetansesok::Jena)
    @jena.stub!(:les_rdf_fil)
    @jena.stub!(:laereplaner)
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
end

