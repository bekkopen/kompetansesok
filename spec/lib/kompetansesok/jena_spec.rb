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
      
      it "should have an array of hovedomraade uuids" do
        @laereplan[:hovedomraade_uuids].should == ["uuid:8f2ce324-6ac3-4ada-98ac-438325404a07", "uuid:7321b950-5720-4ee0-9d25-284d71e4f99e", "uuid:2bd30a81-e4a9-439d-8706-161682c1e95b"]
      end
      
      it "should have an array of kompetansemaalsett uuids" do
        @laereplan[:kompetansemaalsett_uuids].should == ["uuid:7ec420f8-6a1f-4dec-891d-4fd538ee2e8e", "uuid:983fa5ba-8b1a-470e-8d38-c351815acb35", "uuid:7383c30f-0347-43cf-a858-49933dd404e0"]
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
      
      it "should have an array of trinn uuids" do
        @kompetansemaalsett[:trinn_uuids].should == ["http://psi.udir.no/laereplan/aarstrinn/vg1"]
      end
      
      it "should have an array of fag uuids" do
        @kompetansemaalsett[:fag_uuids].should == ["uuid:3ed9705a-b234-4c01-b970-81b288cae332"]
      end
      
      it "should have an array of kompetansemaal uuids" do        
        @kompetansemaalsett[:kompetansemaal_uuids].should include("uuid:a2503251-4713-4667-8c32-e7e77ac6e4d5")
        @kompetansemaalsett[:kompetansemaal_uuids].should include("uuid:9fc982bb-1a4a-47e1-a979-d0db04703d4c")
      end
    end
    
    describe "hovedomraader" do
      before :each do
        @hoovedomraade = @jena.hovedomraader[0]
      end
      
      it "should get uuid" do
        @hoovedomraade[:uuid].should == "uuid:7321b950-5720-4ee0-9d25-284d71e4f99e"
      end

      it "should get tittel" do
        @hoovedomraade[:tittel].should == "Basistrening"
      end
      
      it "should get kode" do
        @hoovedomraade[:kode].should == "kode naar det kommer"
      end
      
      it "should have an array of kompetansemaal uuids" do
        @hoovedomraade[:kompetansemaal_uuids].should include("uuid:a2503251-4713-4667-8c32-e7e77ac6e4d5")
        @hoovedomraade[:kompetansemaal_uuids].should include("uuid:fb8e79d4-5f0d-432e-b983-661feac512d9")
      end
      
    end

    describe "kompetansemaal" do
      before(:each) do
        @alle_kompetansemaal = @jena.kompetansemaal
        @kompetansemaal = @alle_kompetansemaal[0]
      end
      
      it "should get all kompetansemaal, with no duplicates" do
        @alle_kompetansemaal.length.should == 38
      end

      it "should get uuid" do
        @kompetansemaal[:uuid].should == "uuid:7d05a3ca-6195-47a9-b516-d1a78e624e0d"
      end

      it "should get tittel" do
        @kompetansemaal[:tittel].should == "anvende regelverk i den enkelte idrettsaktivitet"
      end
      
      it "should get kode" do
        @kompetansemaal[:kode].should == "kode naar det kommer"
      end
      
      it "should have '<mangler psi>'" do
        @kompetansemaal[:psi].should == "<mangler psi>"
      end

    end
    
    describe "trinn" do
      before :each do
        @trinn = @jena.trinn[0]
      end
      
      it "should get uuid" do
        @trinn[:uuid].should == "http://psi.udir.no/laereplan/aarstrinn/vg1"
      end

      it "should get tittel" do
        @trinn[:tittel].should == "Videregående trinn 1"
      end
    end
    
    
    describe "fag" do
      before :each do
        @fag = @jena.fag[0]
      end
      
      it "should get uuid" do
        @fag[:uuid].should == "uuid:3ed9705a-b234-4c01-b970-81b288cae332"
      end

      it "should get tittel" do
        @fag[:tittel].should == "Aktivitetslære 1"
      end
      
      it "should get kode" do
        @fag[:kode].should == "IDR1Z01"
      end
      
    end
    
    describe "common values" do
      it "should have 'mangler tittel' if tittel is empty" do
        @jena.stub!(:property_content).and_return("")
        @jena.laereplaner[0][:tittel].should == "<mangler tittel>"
      end
      
      it "should have 'mangler kode' if kode is empty" do
        @jena.stub!(:property_content).and_return("")
        @jena.laereplaner[0][:kode].should == "<mangler kode>"
      end
    end

  end
else
  puts "jena_spec må kjøres med JRuby"
end