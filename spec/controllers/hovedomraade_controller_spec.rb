require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HovedomraadeController do

  def mock_hovedomraade(stubs={:kompetansemaal => []})
    @mock_hovedomraade ||= mock_model(Hovedomraade, stubs)
  end

  describe "responding to GET show" do
    before :each do
      Hovedomraade.should_receive(:find_by_uuid).with("uuid-hovedomraade").and_return(mock_hovedomraade)
    end
    
    def do_get(params = {})
      get :show, {:id => "uuid-hovedomraade"}.merge(params)
    end

    it "should expose the requested hovedomraade as @hovedomraade" do
      do_get
      assigns[:hovedomraade].should equal(mock_hovedomraade)
    end
    
    it "should find all kompetansemaal when not filtered by laereplan" do
      kompetansemaal = []
      mock_hovedomraade.should_receive(:kompetansemaal).and_return(kompetansemaal)
      do_get
    end
    
    it "should find kompetansemaal filtered by laereplan if it is nested under laereplan" do
      kompetansemaal = []
      laereplan = mock_model(Laereplan)
      Laereplan.should_receive(:find_by_uuid).with("uuid-laereplan").and_return(laereplan)
      mock_hovedomraade.should_receive(:kompetansemaal_for_laereplan).with(laereplan).and_return(kompetansemaal)
      
      do_get :laereplan_id => "uuid-laereplan"
    end
    
  end

end
