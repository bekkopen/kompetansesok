require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HovedomraaderController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "hovedomraader", :action => "index").should == "/hovedomraader"
    end
  
    it "should map #show" do
      route_for(:controller => "hovedomraader", :action => "show", :id => 1).should == "/hovedomraader/1"
    end
 
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/hovedomraader").should == {:controller => "hovedomraader", :action => "index"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/hovedomraader/1").should == {:controller => "hovedomraader", :action => "show", :id => "1"}
    end
  
  end
end
