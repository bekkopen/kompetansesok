require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplanerController do

  def mock_laereplan(stubs={})
    @mock_laereplan ||= mock_model(Laereplan, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all laereplanerer as @laereplanerer" do
      Laereplan.should_receive(:find).with(:all).and_return([mock_laereplan])
      get :index
      assigns[:laereplaner].should == [mock_laereplan]
    end

    describe "with mime type of xml" do
  
      it "should render all laereplanerer as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Laereplan.should_receive(:find).with(:all).and_return(laereplaner = mock("Array of Laereplaner"))
        laereplaner.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

end
