require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SokController do


  describe "responding to POST download_csv" do
  
    it "should generate csv and expose it as @content" do
      generator = mock(Kompetansesok::CsvGenerator)
      Kompetansesok::CsvGenerator.should_receive(:new).and_return(generator)
      generator.should_receive(:csv_for).with('some-uuids').and_return('as_csv')
    
      post :download_csv, :uuids => 'some-uuids'
      assigns[:content].should == 'as_csv'
    end
  end
  
  describe "responding to Get index" do
    
    it "should create an Info if a search is performed" do
      Info.should_receive(:create)
      
      get :index, :q => "some search"
    end
    
    it "should not create an Info if a search is not performed" do
      Info.should_not_receive(:create)
      
      get :index
    end
    
  end

  
end
