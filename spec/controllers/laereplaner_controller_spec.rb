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

  describe "responding to GET show" do

    it "should expose the requested laereplan as @laereplan" do
      Laereplan.should_receive(:find).with("37").and_return(mock_laereplan)
      get :show, :id => "37"
      assigns[:laereplan].should equal(mock_laereplan)
    end
    
    describe "with mime type of xml" do

      it "should render the requested laereplan as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Laereplan.should_receive(:find).with("37").and_return(mock_laereplan)
        mock_laereplan.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

end
