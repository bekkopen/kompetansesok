require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

if defined?(JRUBY_VERSION)
  describe Kompetansesok::Jena do
    before(:all) do
      @jena = Kompetansesok::Jena.new
      rdf_fil = File.expand_path(File.dirname(__FILE__) + '/../../rdf/test_data.rdf')
      @jena.les_rdf_fil(rdf_fil)
    end

    describe "laereplaner" do
      before(:each) do
        @laereplan = @jena.laereplaner[0]
      end

      it "should get tittel" do
        @laereplan[:tittel].should == "Læreplan i aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"
      end

      it "should get uuid" do
        @laereplan[:uuid].should == "uuid:9bdc529c-09f8-4eda-8c6e-fefe950daac7"
      end

      it "should get kode" do
        @laereplan[:kode].should == "IDR1-01"
      end

    end

    describe "kompetansemaalsett" do
      before(:each) do
        @kompetansemaalsett = @jena.kompetansemaalsett[0]
      end
    
      it "should get uuid" do
        @kompetansemaalsett[:uuid].should == "uuid:7ec420f8-6a1f-4dec-891d-4fd538ee2e8e"
      end

      it "should get tittel" do
        @kompetansemaalsett[:tittel].should == "Aktivitetslære 1"
      end
    end

    describe "kompetansemaal" do
      before(:each) do
        @kompetansemaal = @jena.kompetansemaal[0]

      end

      it "should get uuid" do
        @kompetansemaal[:uuid].should == "uuid:1d129f24-74f3-409b-b56f-57e36af7445c"
      end

      it "should get tittel" do
        @kompetansemaal[:tittel].should == "praktisere dans fra ulike kulturer"
      end

    end

  end
else
  puts " * jena_spec må kjøres med Jruby"
end