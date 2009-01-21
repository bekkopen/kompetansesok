require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplanController do

  def mock_laereplan(stubs={:kompetansemaal => []})
    @mock_fag ||= mock_model(Laereplan, stubs)
  end

  describe "responding to GET show" do

    it "should expose the requested fag as @laereplan" do
      Laereplan.should_receive(:find_by_uuid).with("uuid-38").and_return(mock_laereplan)
      get :show, :id => "uuid-38"
      assigns[:laereplan].should equal(mock_laereplan)
    end
    
  end

end
