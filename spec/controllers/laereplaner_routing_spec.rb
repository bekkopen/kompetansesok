require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplanerController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "laereplaner", :action => "index").should == "/laereplaner"
    end
  
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/laereplaner").should == {:controller => "laereplaner", :action => "index"}
    end 
    
  end
end
