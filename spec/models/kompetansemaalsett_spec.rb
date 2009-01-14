require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kompetansemaalsett do
  before(:each) do
    @valid_attributes = {
      :uuid => "value for uuid",
      :tittel => "value for tittel"
    }
  end
  
  describe "validation" do
    it "should create a new instance given valid attributes" do
      Kompetansemaalsett.create!(@valid_attributes)
    end
    
    it "should have unique uuid" do
      Kompetansemaalsett.create!(@valid_attributes)
      lambda do
        Kompetansemaalsett.create!(@valid_attributes)
      end.should raise_error
    end
    
  end
  
  describe "relationships" do
    before :each do
      @kompetansemaalsett = Kompetansemaalsett.new(@valid_attributes)
    end
    
    it "should have laereplaner" do
      laereplan = Laereplan.new
      @kompetansemaalsett.laereplaner << laereplan
      @kompetansemaalsett.laereplaner.should == [laereplan]
    end
    
    it "should have kompetansemaal" do
      kompetansemaal = Kompetansemaal.new
      @kompetansemaalsett.kompetansemaal << kompetansemaal
      @kompetansemaalsett.kompetansemaal.should == [kompetansemaal]
    end
    
    it "should have trinn" do
      trinn = Trinn.new
      @kompetansemaalsett.trinn << trinn
      @kompetansemaalsett.trinn.should == [trinn]
    end
    
    it "should have fag" do
      fag = Fag.new
      @kompetansemaalsett.fag << fag
      @kompetansemaalsett.fag.should == [fag]
    end
  end
  
end
