require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "kompetansemaal", :action => "index").should == "/kompetansemaal"
    end 
   
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/kompetansemaal").should == {:controller => "kompetansemaal", :action => "index"}
    end
     
  end
end
