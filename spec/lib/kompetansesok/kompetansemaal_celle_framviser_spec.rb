require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::KompetansemaalCelleFramviser do
  class MyView
    include Kompetansesok::KompetansemaalCelleFramviser
    def t(key)
      key
    end
  end

  
  describe "generating details" do
    
    before(:each) do
      @stubs = {
        :tittel => 'tittel',
        :laereplaner => [Laereplan.new(:tittel => "en"), Laereplan.new(:tittel => "to")],
        :hovedomraader => [Hovedomraade.new(:tittel => "h1"), Hovedomraade.new(:tittel => "h2")],
        :kompetansemaalsett => [Kompetansemaalsett.new(:tittel => "k1"), Kompetansemaalsett.new(:tittel => 'k2')],
        :fag => [Fag.new(:tittel => "f1"), Fag.new(:tittel => 'f2')]
      }

      @kompetansemaal = mock("Kompetansemaal",@stubs)
      @kompetansemaal_celle_framviser = MyView.new
    end

    it "should return correct leareplan string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:laereplaner, @kompetansemaal)).should == "en, to"
    end

    it "should return correct hovedomraade string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:hovedomraader, @kompetansemaal)).should == "h1, h2"
    end

    it "should return correct Kompetansemaalsett string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:kompetansemaalsett, @kompetansemaal)).should == "k1, k2"
    end

    it "should return correct fag string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:fag, @kompetansemaal)).should == "f1, f2"
    end

    it "should produce correct html string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal)).should == "Tittelen, toh1, h2k1, k2f1, f2"
    end

    it "should produce correct html string, if no fag is present" do
      @stubs[:fag] = []
      @kompetansemaal = (mock("kompetansemaal",  @stubs))
      @kompetansemaal_celle_framviser = MyView.new 
      strip_styling(@kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal)).should == "Tittelen, toh1, h2k1, k2"
    end

    it "should produce correct styling around the elements" do
      @kompetansemaal_celle_framviser.send(:fag, @kompetansemaal).should == "<span class='kompetansemaal_detaljer'><span class='kompetansemaal_detaljer_fag'>f1, f2</span></span>"
    end
  
  end
  
  
  describe "generating rows" do
    before :each do
      @kompetansemaal_celle_framviser = MyView.new
      @maal = Kompetansemaal.new(:uuid => 'uuid', :tittel => 'tittel', :kode => 'kode')
    end    
    
    it "should have kompetansemaal.uuid at index 0" do
      kompetansemaal = [@maal]
      @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal).first[0].should == 'uuid'
    end
    
    it "should have kompetansemaal.kode at index 1" do
      kompetansemaal = [@maal]
      @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal).first[1].should == 'kode'
    end
    
    it "should have kompetansemaal.tittel at index 2" do
      kompetansemaal = [@maal]
      @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal).first[2].should == 'tittel'
    end
    
    it "should have details at index 3" do
      kompetansemaal = [@maal]
      @kompetansemaal_celle_framviser.should_receive(:to_detail_html).and_return("details")
      @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal).first[3].should == 'details'
    end
    
    it "should not have kompetansemaal.tittel (capitalized) at index 2 if the number of kompetansemaal is higher than a config treshold" do
      kompetansemaal = [@maal]
      max_treshold = 0
      @kompetansemaal_celle_framviser.should_not_receive(:to_detail_html)
      @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal, max_treshold).first[3].should == "Tittel"
    end
    
    
  end
  
  
  
  describe "sorting rows" do
    
    before :each do
      @kompetansemaal_celle_framviser = MyView.new
    end
    
    it "should be sorted by laereplan first" do
      l_1 = Laereplan.new(:tittel => 'laereplan a')
      l_2 = Laereplan.new(:tittel => 'laereplan b')
      h_1 = Hovedomraade.new(:tittel => 'hovedomraade', :laereplaner => [l_1])
      h_2 = Hovedomraade.new(:tittel => 'hovedomraade', :laereplaner => [l_2])
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [h_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [h_2])
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal x'
      sorted[1][2].should == 'maal a'
    end
    
#    it "should be sorted by hovedomraade second" do
#      l_1 = Laereplan.new(:tittel => 'laereplan a')
#      h_1 = Hovedomraade.new(:tittel => 'hovedomraade a', :laereplaner => [l_1])
#      h_2 = Hovedomraade.new(:tittel => 'hovedomraade b', :laereplaner => [l_1])
#      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [h_1])
#      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [h_2])
#    
#      kompetansemaal = [maal_2, maal_1]
#      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
#      
#      sorted[0][2].should == 'maal x'
#      sorted[1][2].should == 'maal a'
#    end
    
    
    
    
    
    
    
    
    
#    it "should be sorted by tittel by default" do
#      maal_1 = Kompetansemaal.new(:tittel => 'maal_1')
#      maal_2 = Kompetansemaal.new(:tittel => 'maal_2')
#      kompetansemaal = [maal_2, maal_1]
#      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
#      
#      sorted.first[2].should == 'maal_1'
#      sorted.last[2].should == 'maal_2'
#    end
#    
#    it "should be sorted first by first given sort field" do
#      h_1 = Hovedomraade.new(:tittel => 'hovedomraade a')
#      h_2 = Hovedomraade.new(:tittel => 'hovedomraade b')
#      maal_1 = Kompetansemaal.new(:tittel => 'maal_1', :hovedomraader => [h_1])
#      maal_2 = Kompetansemaal.new(:tittel => 'maal_2', :hovedomraader => [h_2])
#    
#      kompetansemaal = [maal_2, maal_1]
#      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal, :hovedomraade)
#      
#      sorted[0][2].should == 'maal_1'
#      sorted[1][2].should == 'maal_2'
#    end
#    
#    it "should be sorted by tittel if the first sort_field is equal" do
#      h_1 = Hovedomraade.new(:tittel => 'hovedomraade a')
#      maal_1 = Kompetansemaal.new(:tittel => 'maal_1', :hovedomraader => [h_1])
#      maal_2 = Kompetansemaal.new(:tittel => 'maal_2', :hovedomraader => [h_1])
#    
#      kompetansemaal = [maal_2, maal_1]
#      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal, :hovedomraade)
#      
#      sorted[0][2].should == 'maal_1'
#      sorted[1][2].should == 'maal_2'
#    end 
    
    it "should have nil values sorted last " do
      pending "lage sorteringen først"
      h_1 = Hovedomraade.new(:tittel => 'hovedomraade a')
      maal_1 = Kompetansemaal.new(:uuid => 'uuid_1', :tittel => 'maal', :hovedomraader => [h_1])
      maal_2 = Kompetansemaal.new(:uuid => 'uuid_2',:tittel => 'maal_2')
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][0].should == 'uuid_1'
      sorted[1][0].should == 'uuid_2'
    end
    
  end


  def strip_styling(tekst)
    tekst.gsub(/<[^>]+>/, "")
  end
  
  
end



