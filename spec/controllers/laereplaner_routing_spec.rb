require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplanerController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "laereplaner", :action => "index").should == "/laereplaner"
    end
  
    it "should map #show" do
      route_for(:controller => "laereplaner", :action => "show", :id => 1).should == "/laereplaner/1"
    end

  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/laereplaner").should == {:controller => "laereplaner", :action => "index"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/laereplaner/1").should == {:controller => "laereplaner", :action => "show", :id => "1"}
    end
  
  end
end
