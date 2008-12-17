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
      lambda do
        Laereplan.create!(@valid_attributes)
      end.should raise_error
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
    
    it "should have hovedomraader" do
      hovedomraade = Hovedomraade.new
      @laereplan.hovedomraader << hovedomraade
      @laereplan.hovedomraader.should == [hovedomraade]
    end
    
    it "should have unique list of kompetansemaal" do
      kompetansemaal1 = Kompetansemaal.new
      kompetansemaal2 = Kompetansemaal.new
      kompetansemaalsett1 = Kompetansemaalsett.new
      kompetansemaalsett2 = Kompetansemaalsett.new
      hovedomraade = Hovedomraade.new
      kompetansemaalsett1.kompetansemaal << kompetansemaal1
      kompetansemaalsett2.kompetansemaal << kompetansemaal1
      hovedomraade.kompetansemaal << kompetansemaal2
      @laereplan.kompetansemaalsett << kompetansemaalsett1
      @laereplan.kompetansemaalsett << kompetansemaalsett2
      @laereplan.hovedomraader << hovedomraade
      @laereplan.kompetansemaal.should == [kompetansemaal1, kompetansemaal2]
    end
  end
end
