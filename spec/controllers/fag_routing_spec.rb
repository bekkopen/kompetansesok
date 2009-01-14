require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FagController do
  describe "route generation" do
     
    it "should map #show" do
      route_for(:controller => "fag", :action => "show", :id => 1).should == "/fag/1"
    end
  
  end

  describe "route recognition" do
      
    it "should generate params for #show" do
      params_from(:get, "/fag/1").should == {:controller => "fag", :action => "show", :id => "1"}
    end
  
  end
end
