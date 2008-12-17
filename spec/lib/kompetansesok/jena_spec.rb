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
      
      it "should get hovedomraade uuids" do
        @laereplan[:hovedomraade_uuids].should == ["uuid:7321b950-5720-4ee0-9d25-284d71e4f99e"]
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

      it "should contain an array of laereplan uuids" do
        @kompetansemaalsett[:laereplan_uuids].should == ["uuid:9bdc529c-09f8-4eda-8c6e-fefe950daad0", "uuid:9bdc529c-09f8-4eda-8c6e-fefe950daac7"]
      end
      
      it "should contain an array of trinn uuids" do
        @kompetansemaalsett[:trinn_uuids].should == ["http://psi.udir.no/laereplan/aarstrinn/vg1"]
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

      it "should have an array of kompetansemaallsett uuids" do
        @kompetansemaal[:kompetansemaalsett_uuids].should == ["uuid:983fa5ba-8b1a-470e-8d38-c351815acb35"]
      end
      
      it "should have an array of hovedomraade uuids" do
        @kompetansemaal[:hovedomraade_uuids].should == ["uuid:8f2ce324-6ac3-4ada-98ac-438325404a07"]
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

  end
else
  puts "jena_spec må kjøres med JRuby"
end