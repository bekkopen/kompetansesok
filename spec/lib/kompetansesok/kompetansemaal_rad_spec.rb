require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
 

describe Kompetansesok::KompetansemaalRad do
 
  before :each do
    @rad = Kompetansesok::KompetansemaalRad.new
  end
   
  describe "data row" do
    it "should have maal_uuid at index 0" do
      @rad.kompetansemaal_uuid = "måluuid"
      @rad.to_a[0].should == "måluuid"
    end
    
    it "should have maal_kode at index 1" do
      @rad.kompetansemaal_kode = "målkode"
      @rad.to_a[1].should == "målkode"
    end
    
    it "should have maal_tittel at index 2" do
      @rad.kompetansemaal_tittel = "måltittel"
      @rad.to_a[2].should == "måltittel"
    end
    
    it "should have laereplan_uuid at index 3" do
      @rad.laereplan_uuid = "laereplan_uuid"
      @rad.to_a[3].should == "laereplan_uuid"
    end
    
    it "should have laereplan_kode at index 4" do
      @rad.laereplan_kode = "laereplan_kode"
      @rad.to_a[4].should == "laereplan_kode"
    end
    
    it "should have laereplan_tittel at index 5" do
      @rad.laereplan_tittel = "laereplan_tittel"
      @rad.to_a[5].should == "laereplan_tittel"
    end
 
    it "should have hovedomraade_uuid at index 6" do
      @rad.hovedomraade_uuid = "hovedomraade_uuid"
      @rad.to_a[6].should == "hovedomraade_uuid"
    end
    
    it "should have hovedomraade_kode at index 7" do
      @rad.hovedomraade_kode = "hovedomraade_kode"
      @rad.to_a[7].should == "hovedomraade_kode"
    end
    
    it "should have hovedomraade_tittel at index 8" do
      @rad.hovedomraade_tittel = "hovedomraade_tittel"
      @rad.to_a[8].should == "hovedomraade_tittel"
    end 

    it "should have kompetansemaalsett_uuid at index 9" do
      @rad.kompetansemaalsett_uuid = "kompetansemaalsett_uuid"
      @rad.to_a[9].should == "kompetansemaalsett_uuid"
    end
    
    it "should have kompetansemaalsett_kode at index 10" do
      @rad.kompetansemaalsett_kode = "kompetansemaalsett_kode"
      @rad.to_a[10].should == "kompetansemaalsett_kode"
    end
    
    it "should have kompetansemaalsett_tittel at index 11" do
      @rad.kompetansemaalsett_tittel = "kompetansemaalsett_tittel"
      @rad.to_a[11].should == "kompetansemaalsett_tittel"
    end
    
    it "should have fag_uuid at index 12" do
      @rad.fag_uuid = "fag_uuid"
      @rad.to_a[12].should == "fag_uuid"
    end
    
    it "should have fag_kode at index 13" do
      @rad.fag_kode = "fag_kode"
      @rad.to_a[13].should == "fag_kode"
    end
    
    it "should have fag_tittel at index 14" do
      @rad.fag_tittel = "fag_tittel"
      @rad.to_a[14].should == "fag_tittel"
    end
    
  end
  
  
end