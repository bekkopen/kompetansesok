require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Trinn do
  before(:each) do
    @valid_attributes = {
      :uuid => "value for uuid",
      :tittel => "value for tittel"
    }
  end

  describe "validation" do
    it "should create a new instance given valid attributes" do
      Trinn.create!(@valid_attributes)
    end
    
    it "should have unique uuid" do
      Trinn.create!(@valid_attributes)
      lambda do
        Trinn.create!(@valid_attributes)
      end.should raise_error
    end
  end
end
