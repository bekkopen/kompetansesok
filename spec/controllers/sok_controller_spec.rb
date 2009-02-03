require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SokController do


  describe "responding to POST download_csv" do
    before :each do
      @generator = mock(Kompetansesok::CsvGenerator)
      Kompetansesok::CsvGenerator.should_receive(:new).and_return(generator)
    end

    it "should generate csv and expose it as @content" do
      @generator.should_receive(:csv_for).with('some-uuids').and_return("as_csv, --")
      post :download_csv, :uuids => 'some-uuids'
      assigns[:content].should == c.iconv("as_csv, --")
    end

    it "should generate csv on ISO-8859-15" do
      @generator.should_receive(:csv_for).with('some-uuids').and_return("æøå, --")
      post :download_csv, :uuids => 'some-uuids'
      c = Iconv.new('ISO-8859-15','UTF-8')
      assigns[:content].should == c.iconv("æøå, --")
      response.headers["type"].should == "text/csv; charset=ISO-8859-15"
    end

    it "should generate csv striped for special chars" do
      special_to_replace_characters = {"–" => "-"}
      @generator.should_receive(:csv_for).with('some-uuids').and_return(special_to_replace_characters.keys)
      post :download_csv, :uuids => 'some-uuids'
      c = Iconv.new('ISO-8859-15','UTF-8')
      assigns[:content].should == c.iconv(special_to_replace_characters.values)
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
