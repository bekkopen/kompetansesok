require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaereplansokController do

  describe "dropdown_content" do
    it "should generate options for kompetansemaalsett" do
      laereplansok = mock_model(Laereplansok)
      Laereplansok.should_receive(:new).and_return(laereplansok)
      laereplansok.should_receive(:kompetansemaalsett).and_return([mock_model(Kompetansemaalsett, :uuid => "uuid", :tittel => "tittel")])
      
      get :dropdown_content
      
      assigns[:kompetansemaalsett_options].should == [[], ["uuid", "tittel"]]
    end
    
  end
  

end
