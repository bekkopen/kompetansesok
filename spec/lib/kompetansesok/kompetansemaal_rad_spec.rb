require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::KompetansemaalRad do
  
  before :each do
    @rad = Kompetansesok::KompetansemaalRad.new
  end  
  
  
  describe "as_row" do
    it "should have laereplan_tittel as the 1st column" do
      @rad.laereplan_tittel = "læreplan"
      @rad.as_row[0].should == "læreplan"
    end
    
    it "should have hovedomraade_tittel as the 2nd column" do
      @rad.hovedomraade_tittel = "hovedområde"
      @rad.as_row[1].should == "hovedområde"
    end
    
    it "should have kompetansemaalsett_tittel as the 3rd column" do
      @rad.kompetansemaalsett_tittel = "kompetansemålsett"
      @rad.as_row[2].should == "kompetansemålsett"
    end
    
    it "should have trinn_tittel as the 4th column" do
      @rad.trinn_tittel = "trinn"
      @rad.as_row[3].should == "trinn"
    end
    
    it "should have maal_uuid as the 5th column" do
      @rad.maal_uuid = "måluuid"
      @rad.as_row[4].should == "måluuid"
    end
    
    it "should have maal_kode as the 6th column" do
      @rad.maal_kode = "målkode"
      @rad.as_row[5].should == "målkode"
    end
    
    it "should have maal_tittel as the 7th column" do
      @rad.maal_tittel = "måltittel"
      @rad.as_row[6].should == "måltittel"
    end
  end
  
  
end