require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FagController do

  def mock_fag(stubs={:kompetansemaal => []})
    @mock_fag ||= mock_model(Fag, stubs)
  end

  describe "responding to GET show" do
    
    before :each do
      Fag.stub!(:find_by_uuid).and_return(mock_fag)
      controller.stub!(:lag_kompetansemaalrader)
      controller.stub!(:lag_brodsmuler)
    end
    
    def do_get
      get :show, :id => "uuid-37"
    end

    it "should expose the requested fag as @fag" do
      Fag.should_receive(:find_by_uuid).with("uuid-37").and_return(mock_fag({:kompetansemaal => []}))
      
      do_get
      assigns[:fag].should equal(mock_fag)
    end
  end

end
