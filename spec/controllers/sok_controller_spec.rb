require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SokController do

  before :each do
    Kompetansemaal.create(:uuid =>"uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631", :kode => "kode")
    Kompetansemaal.create({:kode => "kode1",:uuid => "uuid:c056ac28-0517-4336-999e-0a98d4d7c4f2"});
  end
  
  it "give empty file if no params is set" do
    post :download_csv, :uuids => ""
    
    assigns[:content].should == ""
  end

  it "should give a empty file if no checkboxes is set" do
    post :download_csv, :uuids => "uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631,uuid:c056ac28-0517-4336-999e-0a98d4d7c4f2"

    assigns[:content].should == ""
  end

  it "should give a list of two correct uuids upon entering correct uuids and checking the showId box" do
    post :download_csv, {"uuids" => "uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631,uuid:c056ac28-0517-4336-999e-0a98d4d7c4f2", "showId" => "on"}

    assigns[:content].should == "uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631\nuuid:c056ac28-0517-4336-999e-0a98d4d7c4f2\n"
  end

  it "should give a list of uuids and kode if turned on" do
    post :download_csv, {"uuids" => "uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631,uuid:c056ac28-0517-4336-999e-0a98d4d7c4f2", "showId" => "on", "showKode" => "on"}

    assigns[:content].should == "uuid:c405c2f1-7e1d-4ab5-829d-d9b757c94631,kode\nuuid:c056ac28-0517-4336-999e-0a98d4d7c4f2,kode1\n"
  end


end
