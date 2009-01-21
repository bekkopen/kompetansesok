require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FagController do

  def mock_fag(stubs={})
    @mock_fag ||= mock_model(Fag, stubs)
  end

  describe "responding to GET show" do

    it "should expose the requested fag as @fag" do
      Fag.should_receive(:find_by_uuid).with("uuid-37").and_return(mock_fag({:kompetansemaal => []}))
      get :show, :id => "uuid-37"
      assigns[:fag].should equal(mock_fag)
    end
    
  end

end
