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
    
    it "should have kompetansemaal" do
      maal = Kompetansemaal.new
      @hovedomraade.kompetansemaal << maal
      @hovedomraade.kompetansemaal.should == [maal]
    end
    
    it "should have laereplaner" do
      plan = Laereplan.new
      @hovedomraade.laereplaner << plan
      @hovedomraade.laereplaner.should == [plan]
    end
  end
end
