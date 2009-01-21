require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hovedomraade do
  before(:each) do
    @valid_attributes = {
      :uuid => "value for uuid",
      :tittel => "value for tittel"
    }
  end

  describe "validation" do
    it "should create a new instance given valid attributes" do
      Hovedomraade.create!(@valid_attributes)
    end
    
    it "should have unique uuid" do
      Hovedomraade.create!(@valid_attributes)
      lambda do
        Hovedomraade.create!(@valid_attributes)
      end.should raise_error
    end
  end
  
  describe "relationships" do
    before :each do
      @hovedomraade = Hovedomraade.new
    end
    
    it "should have laereplaner" do
      plan = Laereplan.new
      @hovedomraade.laereplaner << plan
      @hovedomraade.laereplaner.should == [plan]
    end
    
    it "should have kompetansemaal" do
      maal = Kompetansemaal.new
      @hovedomraade.kompetansemaal << maal
      @hovedomraade.kompetansemaal.should == [maal]
    end
    
    it "should have kompetansemaal for a laereplan filtered on kompetansemaalsett" do
      laereplan1 = Laereplan.new
      laereplan2 = Laereplan.new
      maalsett1 = Kompetansemaalsett.new(:laereplaner => [laereplan1])
      maalsett2 = Kompetansemaalsett.new(:laereplaner => [laereplan2])
      maal1 = Kompetansemaal.new(:kompetansemaalsett => [maalsett1])
      maal2 = Kompetansemaal.new(:kompetansemaalsett => [maalsett2])
      @hovedomraade.laereplaner << laereplan1 
      @hovedomraade.kompetansemaal << maal1
      @hovedomraade.kompetansemaal << maal2
      
      @hovedomraade.kompetansemaal_for_laereplan(laereplan1).should == [maal1]
    end
    
    it "should have kompetansemaalsett through kompetansemaal" do
      maalsett1 = Kompetansemaalsett.new
      maalsett2 = Kompetansemaalsett.new
      maal1 = Kompetansemaal.new(:kompetansemaalsett => [maalsett1])
      maal2 = Kompetansemaal.new(:kompetansemaalsett => [maalsett2])
      @hovedomraade.kompetansemaal << maal1
      @hovedomraade.kompetansemaal << maal2
      
      @hovedomraade.kompetansemaalsett.should == [maalsett1, maalsett2]
    end
    
  end
end
