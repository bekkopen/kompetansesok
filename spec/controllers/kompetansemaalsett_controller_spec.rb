require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalsettController do

  def mock_kompetansemaalsett(stubs={:kompetansemaal => [], :tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'KS'})
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
      hovedomraade = mock_model(Hovedomraade, {:tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'H'})
      Hovedomraade.should_receive(:find_by_uuid).with("uuid-hovedomraade").and_return(hovedomraade)
      mock_kompetansemaalsett.should_receive(:kompetansemaal_for_hovedomraade).with(hovedomraade).and_return(kompetansemaal)
      
      do_get :hovedomraade_id => "uuid-hovedomraade"
    end
    
    it "should expose @throug_hovedomraade if nested under hovedomraade" do
      hovedomraade = mock_model(Hovedomraade, {:tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'H'})
      Hovedomraade.should_receive(:find_by_uuid).and_return(hovedomraade)
      mock_kompetansemaalsett.stub!(:kompetansemaal_for_hovedomraade).and_return([])
      do_get :hovedomraade_id => "uuid-hovedomraade"
      assigns[:through_hovedomraade].should be_true
    end
    
    it "should not expose @throug_hovedomraade if not nested under hovedomraade" do
      do_get
      assigns[:through_hovedomraade].should be_nil
    end
    
    it "should expose @throug_laereplan if nested under laereplan" do
      Laereplan.should_receive(:find_by_uuid).and_return(mock_model(Laereplan, {:tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'L'}))
      do_get :laereplan_id => "uuid-laereplan"
      assigns[:through_laereplan].should be_true
    end
    
    it "should not expose @throug_laereplan if not nested under laereplan" do
      do_get
      assigns[:through_laereplan].should be_nil
    end
    
  end

end
