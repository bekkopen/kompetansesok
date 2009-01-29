require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HovedomraadeController do

  def mock_hovedomraade(stubs={:kompetansemaal => [], :tittel=>"tittel", :uuid=>"uuid", :ikon_tekst => 'H'})
    @mock_hovedomraade ||= mock_model(Hovedomraade, stubs)
  end

  describe "responding to GET show" do
    before :each do
      Hovedomraade.should_receive(:find_by_uuid).with("uuid-hovedomraade").and_return(mock_hovedomraade)
      mock_hovedomraade.stub!(:kompetansemaalsett, {:tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'KS'})
    end
    
    def do_get(params = {})
      get :show, {:id => "uuid-hovedomraade", :ikon_tekst => 'H'}.merge(params)
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
    
    it "should expose all kompetansemaalsett when not filtered by laereplan" do
      kompetansemaalsett = []
      mock_hovedomraade.should_receive(:kompetansemaalsett).and_return(kompetansemaalsett)
      
      do_get
      assigns[:kompetansemaalsett].should == kompetansemaalsett
    end
    
    
    it "should not expose @throug_laereplan if not nested under laereplan" do
      do_get
      assigns[:through_laereplan].should be_nil
    end

    describe "nested under laereplan" do
      before :each do
        mock_hovedomraade.stub!(:kompetansemaal_for_laereplan).and_return([])
        mock_hovedomraade.stub!(:kompetansemaalsett_for_laereplan).and_return([])
      end
      
      it "should find kompetansemaal filtered by laereplan" do
        kompetansemaal = []
        laereplan = mock_model(Laereplan, {:tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'LP'})
        Laereplan.should_receive(:find_by_uuid).with("uuid-laereplan").and_return(laereplan)
        mock_hovedomraade.should_receive(:kompetansemaal_for_laereplan).with(laereplan).and_return(kompetansemaal)
      
        do_get :laereplan_id => "uuid-laereplan"
      end
      
      it "should expose kompetansemaalsett filtered by laereplan" do
        kompetansemaalsett = []
        mock_hovedomraade.should_receive(:kompetansemaalsett_for_laereplan).and_return(kompetansemaalsett)
      
        do_get :laereplan_id => "uuid-laereplan"
        assigns[:kompetansemaalsett].should == kompetansemaalsett
      end
      
      it "should expose @throug_laereplan if nested under laereplan" do
        Laereplan.should_receive(:find_by_uuid).and_return(mock_model(Laereplan, {:tittel => "tittel", :uuid => "uuid", :ikon_tekst => 'L'}))
        do_get :laereplan_id => "uuid-laereplan"
        assigns[:through_laereplan].should be_true
      end
    end
  end
end
