require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplansokController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "laereplansok", :action => "index").should == "/laereplansok"
    end
  
    it "should map #new" do
      route_for(:controller => "laereplansok", :action => "new").should == "/laereplansok/new"
    end
  
    it "should map #show" do
      route_for(:controller => "laereplansok", :action => "show", :id => 1).should == "/laereplansok/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "laereplansok", :action => "edit", :id => 1).should == "/laereplansok/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "laereplansok", :action => "update", :id => 1).should == "/laereplansok/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "laereplansok", :action => "destroy", :id => 1).should == "/laereplansok/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/laereplansok").should == {:controller => "laereplansok", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/laereplansok/new").should == {:controller => "laereplansok", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/laereplansok").should == {:controller => "laereplansok", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/laereplansok/1").should == {:controller => "laereplansok", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/laereplansok/1/edit").should == {:controller => "laereplansok", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/laereplansok/1").should == {:controller => "laereplansok", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/laereplansok/1").should == {:controller => "laereplansok", :action => "destroy", :id => "1"}
    end
  end
end
