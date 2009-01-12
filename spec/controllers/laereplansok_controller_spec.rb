require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplansokController do

  describe "dropdown_content" do
    before :each do
      @laereplansok = mock_model(Laereplansok)
      Laereplansok.stub!(:new).and_return(@laereplansok)
      @laereplansok.stub!(:trinn).and_return([mock_model(Trinn, :uuid => "trinn_uuid", :tittel => "trinn_tittel")])
      @laereplansok.stub!(:kompetansemaalsett).and_return([mock_model(Kompetansemaalsett, :uuid => "maalsett_uuid", :tittel => "maalsett_tittel")])
    end
    
    it "should generate options for kompetansemaalsett" do     
      get :dropdown_content
      assigns[:kompetansemaalsett_options].should == [[], ["maalsett_uuid", "maalsett_tittel"]]
    end
    
    it "should generate options for trinn" do
      get :dropdown_content
      assigns[:trinn_options].should == [[], ["trinn_uuid", "trinn_tittel"]]
    end
    
  end
  

end
