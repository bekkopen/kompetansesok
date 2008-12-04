# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Kompetansemaal do
  before(:each) do
    @vaidattribute = {
      :tittel => "Kompetanse maal tittel",
      :uuid => "adfg"
    }

  end

  it "should accssept valid attributes" do
    @kompetansemaal = Kompetansemaal.create!(@validattribute)
  end

  describe "validation" do
    it "should have unique uuid" do
      Kompetansemaal.create!(@valid_attributes)
      invalid_maal = Kompetansemaal.new(@valid_attributes)
      invalid_maal.should_not be_valid
    end
  end
end

