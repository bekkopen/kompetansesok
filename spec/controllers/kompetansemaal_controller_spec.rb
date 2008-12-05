require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalController do

  def mock_kompetansemaal(stubs={})
    @mock_kompetansemaal ||= mock_model(Kompetansemaal, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all kompetansemaal as @kompetansemaal" do
      Kompetansemaal.should_receive(:find).with(:all).and_return([mock_kompetansemaal])
      get :index
      assigns[:kompetansemaal].should == [mock_kompetansemaal]
    end

    describe "with mime type of xml" do
  
      it "should render all kompetansemaal as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Kompetansemaal.should_receive(:find).with(:all).and_return(kompetansemaal = mock("Array of Kompetansemaal"))
        kompetansemaal.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

end
