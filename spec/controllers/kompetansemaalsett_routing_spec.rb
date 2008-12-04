require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalsettController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "kompetansemaalsett", :action => "index").should == "/kompetansemaalsett"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/kompetansemaalsett").should == {:controller => "kompetansemaalsett", :action => "index"}
    end
  end
end
