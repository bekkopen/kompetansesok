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
      invalid_maalsett = Kompetansemaalsett.new(@valid_attributes)
      invalid_maalsett.should_not be_valid
    end
    
  end
  
  describe "relationships" do
    before :each do
      @kompetansemaalsett = Kompetansemaalsett.new(@valid_attributes)
    end
    
    it "should have a laereplan" do
      laereplan = Laereplan.new
      @kompetansemaalsett.laereplaner << laereplan
      @kompetansemaalsett.laereplan.should == laereplan
    end
    
    it "should have kompetansemaal" do
      kompetansemaal = Kompetansemaal.new
      @kompetansemaalsett.kompetansemaal << kompetansemaal
      @kompetansemaalsett.kompetansemaal.should == [kompetansemaal]
    end
  end
  
end
