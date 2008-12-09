require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HovedomraaderController do

  def mock_hovedomraade(stubs={})
    @mock_hovedomraade ||= mock_model(Hovedomraade, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all hovedomraaderer as @hovedomraaderer" do
      Hovedomraade.should_receive(:find).with(:all).and_return([mock_hovedomraade])
      get :index
      assigns[:hovedomraader].should == [mock_hovedomraade]
    end

  end

  describe "responding to GET show" do

    it "should expose the requested hovedomraade as @hovedomraade" do
      Hovedomraade.should_receive(:find).with("37").and_return(mock_hovedomraade)
      get :show, :id => "37"
      assigns[:hovedomraade].should equal(mock_hovedomraade)
    end

  end

end
