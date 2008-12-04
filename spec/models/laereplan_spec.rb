require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Laereplan do
  before(:each) do
    @valid_attributes = {
      :kode => "value for kode",
      :tittel => "value for tittle",
      :uuid => "en eller annen streng"
    }
  end

  it "should create a new instance given valid attributes" do
    Laereplan.create!(@valid_attributes)
  end
  
  describe "validation" do
    it "should have unique uuid" do
      Laereplan.create!(@valid_attributes)
      invalid_laereplan = Laereplan.new(@valid_attributes)
      invalid_laereplan.should_not be_valid
    end
  end
end
