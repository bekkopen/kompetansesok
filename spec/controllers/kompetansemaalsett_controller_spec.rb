require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalsettController do

  def mock_kompetansemaalsett(stubs={})
    @mock_kompetansemaalsett ||= mock_model(Kompetansemaalsett, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all kompetansemaalsett as @kompetansemaalsett" do
      Kompetansemaalsett.should_receive(:find).with(:all).and_return([mock_kompetansemaalsett])
      get :index
      assigns[:kompetansemaalsett].should == [mock_kompetansemaalsett]
    end

    describe "with mime type of xml" do
  
      it "should render all kompetansemaalsett as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Kompetansemaalsett.should_receive(:find).with(:all).and_return(kompetansemaalsett = mock("Array of Kompetansemaalsett"))
        kompetansemaalsett.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end


end
