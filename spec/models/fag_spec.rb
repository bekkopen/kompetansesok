require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fag do
  before(:each) do
    @valid_attributes = {
      :uuid => "value for uuid",
      :kode => "value for kode",
      :tittel => "value for tittel"
    }
  end

  it "should create a new instance given valid attributes" do
    Fag.create!(@valid_attributes)
  end
  
  describe "relationships" do
    before :each do
      @fag = Fag.new(@valid_attributes)
    end
    
    it "should have kompetansemaalsett" do
      kompetansemaalsett = Kompetansemaalsett.new
      @fag.kompetansemaalsett << kompetansemaalsett
      @fag.kompetansemaalsett.should == [kompetansemaalsett]
    end
    
    it "should have unique list of kompetansemaal" do
      kompetansemaal1 = Kompetansemaal.new
      kompetansemaal2 = Kompetansemaal.new
      kompetansemaalsett1 = Kompetansemaalsett.new
      kompetansemaalsett2 = Kompetansemaalsett.new
      kompetansemaalsett1.kompetansemaal << kompetansemaal1
      kompetansemaalsett1.kompetansemaal << kompetansemaal2
      kompetansemaalsett2.kompetansemaal << kompetansemaal1
      
      @fag.kompetansemaalsett << kompetansemaalsett1
      @fag.kompetansemaalsett << kompetansemaalsett2
      @fag.kompetansemaal.should == [kompetansemaal1, kompetansemaal2]
    end
   
  end
end
