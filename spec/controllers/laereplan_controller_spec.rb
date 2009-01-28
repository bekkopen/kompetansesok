require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplanController do
  describe "responding to GET show" do
    it "should expose the requested fag as @laereplan" do
      laereplan = mock_model(Laereplan, :kompetansemaal => [], :tittel=>"tittel", :uuid =>"uuid", :ikon_tekst => 'LP')
      Laereplan.should_receive(:find_by_uuid).with("uuid-38").and_return(laereplan)
      get :show, :id => "uuid-38"
      assigns[:laereplan].should equal(laereplan)
    end
  end
end
