require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kompetansemaal do
  before(:each) do
    @vaidattribute = {
      :tittel => "Kompetanse maal tittel"
    }
  end

  it "should accssept valid attributes" do
    @kompetansemaal = Kompetansemaal.create!(@validattribute)
  end
end

