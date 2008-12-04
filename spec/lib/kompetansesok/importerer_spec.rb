require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

if defined?(JRUBY_VERSION)
  describe Kompetansesok::Importerer do
    before(:each) do
      @importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
      @jena = mock(Kompetansesok::Jena)
      @jena.stub!(:les_rdf_fil)
      @jena.stub!(:laereplaner)
      @jena.stub!(:kompetansemaalsett)
      @jena.stub!(:kompetansemaal)
      Kompetansesok::Jena.stub!(:new).and_return(@jena)
    end

    describe "import of laereplaner" do
      before :each do
        laereplaner_array = [{:uuid => "uuid", :tittel => "tittel", :kode => "kode"}]
        @jena.should_receive(:laereplaner).and_return(laereplaner_array)
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
        kompetansemaalsett_array = [{:uuid => "uuid", :tittel => "tittel"}]
        @jena.should_receive(:kompetansemaalsett).and_return(kompetansemaalsett_array)
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

    describe "import of kompetansemaal" do
      before :each do
        Kompetansemaalsett.stub!(:find_by_uuid).and_return(Kompetansemaalsett.new)
        kompetansemaal_array = [{:tittel => "dette er en tittel", :uuid => "asas"}]
        @jena.should_receive(:kompetansemaal).and_return(kompetansemaal_array)
        @importerer.importer_til_db(1)
        @kompetansemaal = Kompetansemaal.find :first
      end

      it "should contain tittel" do
        @kompetansemaal.tittel.should == "dette er en tittel"
      end

      it "should contain uuid" do
        @kompetansemaal.uuid.should == "asas"
      end
   
    end
  end
else
  puts " * importer_spec må kjøres med Jruby"
end