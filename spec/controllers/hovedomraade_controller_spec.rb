require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HovedomraadeController do

  def mock_hovedomraade(stubs={:kompetansemaal => []})
    @mock_hovedomraade ||= mock_model(Hovedomraade, stubs)
  end

  describe "responding to GET show" do

    it "should expose the requested fag as @hovedomraade" do
      Hovedomraade.should_receive(:find_by_uuid).with("uuid-36").and_return(mock_hovedomraade)
      get :show, :id => "uuid-36"
      assigns[:hovedomraade].should equal(mock_hovedomraade)
    end
    
  end

end
