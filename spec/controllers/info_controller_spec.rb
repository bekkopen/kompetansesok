require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InfoController do

  describe "responding to GET statistikk" do

    it "should expose seach statistics as @statistikk" do
      statistikk = {:some => 'this'}
      Info.should_receive(:sok_statistikk).and_return(statistikk)
      
      get :statistikk
      assigns[:statistikk].should equal(statistikk)
    end
  end

end
