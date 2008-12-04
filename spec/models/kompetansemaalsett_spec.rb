require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kompetansemaalsett do
  before(:each) do
    @valid_attributes = {
      :uuid => "value for uuid",
      :tittel => "value for tittel"
    }
  end

  it "should create a new instance given valid attributes" do
    Kompetansemaalsett.create!(@valid_attributes)
  end
  
  describe "validation" do
    it "should have unique uuid" do
      Kompetansemaalsett.create!(@valid_attributes)
      invalid_maalsett = Kompetansemaalsett.new(@valid_attributes)
      invalid_maalsett.should_not be_valid
    end
  end
end
