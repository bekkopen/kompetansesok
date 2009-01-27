require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SokController do

  before :each do
    Kompetansemaal.create(:uuid =>"uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631", :kode => "kode")
    Kompetansemaal.create({:kode => "kode1",:uuid => "uuid:c056ac28-0517-4336-999e-0a98d4d7c4f2"});
  end
  
  it "should generate csv and expose it as @content" do
    generator = mock(Kompetansesok::CsvGenerator)
    Kompetansesok::CsvGenerator.should_receive(:new).and_return(generator)
    generator.should_receive(:csv_for).with('some-uuids').and_return('as_csv')
    
    post :download_csv, :uuids => 'some-uuids'
    assigns[:content].should == 'as_csv'
  end

  
end
