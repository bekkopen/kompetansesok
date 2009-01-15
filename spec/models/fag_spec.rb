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
end
