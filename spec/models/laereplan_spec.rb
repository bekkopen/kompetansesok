require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Laereplan do
  before(:each) do
    @valid_attributes = {
      :kode => "value for kode",
      :tittel => "value for tittle",
      :uuid => "en eller annen streng"
    }
  end
  
  describe "validation" do
    it "should create a new instance given valid attributes" do
      Laereplan.create!(@valid_attributes)
    end
    
    it "should have unique uuid" do
      Laereplan.create!(@valid_attributes)
      invalid_laereplan = Laereplan.new(@valid_attributes)
      invalid_laereplan.should_not be_valid
    end
  end
  
  describe "relationships" do
    before :each do
      @laereplan = Laereplan.new(@valid_attributes)
    end
    
    it "should have kompetansemaalsett" do
      kompetansemaalsett = Kompetansemaalsett.new
      @laereplan.kompetansemaalsett << kompetansemaalsett
      @laereplan.kompetansemaalsett.should == [kompetansemaalsett]
    end
    
    it "should have unique list of kompetansemaal" do
      kompetansemaal = Kompetansemaal.new
      kompetansemaalsett1 = Kompetansemaalsett.new
      kompetansemaalsett2 = Kompetansemaalsett.new
      kompetansemaalsett1.kompetansemaal << kompetansemaal
      kompetansemaalsett2.kompetansemaal << kompetansemaal
      @laereplan.kompetansemaalsett << kompetansemaalsett1
      @laereplan.kompetansemaalsett << kompetansemaalsett2
      @laereplan.kompetansemaal.should == [kompetansemaal]
    end
  end
end
