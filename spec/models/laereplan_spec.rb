require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Laereplan do
  before(:each) do
    @valid_attributes = {
      :kode => "value for kode",
      :tittle => "value for tittle"
    }
  end

  it "should create a new instance given valid attributes" do
    Laereplan.create!(@valid_attributes)
  end
end
