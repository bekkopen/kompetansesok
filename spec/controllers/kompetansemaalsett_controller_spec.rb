require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalsettController do

  def mock_kompetansemaalsett(stubs={:kompetansemaal => [], :tittel => "tittel", :uuid => "uuid"})
    @mock_kompetansemaalsett ||= mock_model(Kompetansemaalsett, stubs)
  end

  describe "responding to GET show" do
    before :each do
      Kompetansemaalsett.should_receive(:find_by_uuid).with("uuid-kompetansemaalsett").and_return(mock_kompetansemaalsett)
    end
    
    def do_get(params = {})
      get :show, {:id => "uuid-kompetansemaalsett"}.merge(params)
    end

    it "should expose the requested kompetansemaalsett as @kompetansemaalsett" do
      do_get
      assigns[:kompetansemaalsett].should equal(mock_kompetansemaalsett)
    end
    
    it "should find all kompetansemaal when not filtered by hovedomraade" do
      kompetansemaal = []
      mock_kompetansemaalsett.should_receive(:kompetansemaal).and_return(kompetansemaal)
      do_get
    end
    
    it "should find kompetansemaal filtered by hovedomraade if it is nested under hovedomraade" do
      kompetansemaal = []
      hovedomraade = mock_model(Hovedomraade, {:tittel => "tittel", :uuid => "uuid"})
      Hovedomraade.should_receive(:find_by_uuid).with("uuid-hovedomraade").and_return(hovedomraade)
      mock_kompetansemaalsett.should_receive(:kompetansemaal_for_hovedomraade).with(hovedomraade).and_return(kompetansemaal)
      
      do_get :hovedomraade_id => "uuid-hovedomraade"
    end
    
  end

end
