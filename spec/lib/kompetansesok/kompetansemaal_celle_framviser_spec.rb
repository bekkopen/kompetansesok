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
        :laereplaner => [Laereplan.new(:uuid=> 'uuid-1', :tittel => "plan1"), Laereplan.new(:uuid=> 'uuid-2', :tittel => "plan2")],
        :hovedomraader => [Hovedomraade.new(:tittel => "h1"), Hovedomraade.new(:tittel => "h2")],
        :kompetansemaalsett => [Kompetansemaalsett.new(:tittel => "k1"), Kompetansemaalsett.new(:tittel => 'k2')],
        :fag => [Fag.new(:tittel => "f1"), Fag.new(:tittel => 'f2')]
      }

      @kompetansemaal = mock("Kompetansemaal",@stubs)
      @kompetansemaal_celle_framviser = MyView.new
    end

    it "should return correct leareplan string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:laereplaner, @kompetansemaal)).should == "LP <a href=''>plan1</a>, <a href=''>plan2</a>"
    end

    it "should return correct hovedomraade string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:hovedomraader, @kompetansemaal)).should == "H&nbsp; h1, h2"
    end

    it "should return correct Kompetansemaalsett string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:kompetansemaalsett, @kompetansemaal)).should == "KS k1, k2"
    end

    it "should return correct fag string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:fag, @kompetansemaal)).should == "F&nbsp; f1, f2"
    end

    it "should produce correct html string" do
      strip_styling(@kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal)).should == 
        "TittelLP plan1, plan2H&nbsp; h1, h2KS k1, k2F&nbsp; f1, f2"
    end

    it "should produce correct html string, if no fag is present" do
      @stubs[:fag] = []
      @kompetansemaal = (mock("kompetansemaal",  @stubs))
      @kompetansemaal_celle_framviser = MyView.new 
      strip_styling(@kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal)).should == 
        "TittelLP plan1, plan2H&nbsp; h1, h2KS k1, k2"
    end

    it "should produce correct styling around the elements" do
      @kompetansemaal_celle_framviser.send(:fag, @kompetansemaal).should == 
        "<div class='kompetansemaal_detaljer'><span class='ikon ikon_Fag'>F&nbsp;</span> f1, f2</div>"
    end
  
  end
  
  
  describe "generating rows" do
    before :each do
      @kompetansemaal_celle_framviser = MyView.new
      @kompetansemaal = [Kompetansemaal.new(:uuid => 'uuid', :tittel => 'tittel', :kode => 'kode')]
    end    
    
    it "should have kompetansemaal.uuid at index 0" do
      @kompetansemaal_celle_framviser.send(:generate_unsorted_rows, @kompetansemaal).first[0].should == 'uuid'
    end
    
    it "should have kompetansemaal.kode at index 1" do
      @kompetansemaal_celle_framviser.send(:generate_unsorted_rows, @kompetansemaal).first[1].should == 'kode'
    end
    
    it "should have kompetansemaal.tittel at index 2" do
      @kompetansemaal_celle_framviser.send(:generate_unsorted_rows, @kompetansemaal).first[2].should == 'tittel'
    end
        
    it "should not have kompetansemaal.tittel (capitalized) at index 2 if the number of kompetansemaal is higher than a config treshold" do
      max_treshold = 0
      @kompetansemaal_celle_framviser.should_not_receive(:to_detail_html)
      @kompetansemaal_celle_framviser.send(:generate_unsorted_rows, @kompetansemaal, [], max_treshold).first[3].should == "Tittel"
    end
    
    
    describe "details" do
      it "should be at index 3" do
        @kompetansemaal_celle_framviser.should_receive(:to_detail_html).and_return("details")
        @kompetansemaal_celle_framviser.send(:generate_unsorted_rows, @kompetansemaal).first[3].should == 'details'
      end
      
      it "should not include laereplaner if it is told to skip it" do
        skip_details_for = [:laereplaner]
        @kompetansemaal_celle_framviser.should_not_receive(:laereplaner)
        @kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal.first, skip_details_for)
      end
      
      it "should not include hovedomraader if it is told to skip it" do
        skip_details_for = [:hovedomraader]
        @kompetansemaal_celle_framviser.should_not_receive(:hovedomraader)
        @kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal.first, skip_details_for)
      end
      
      it "should not include fag if it is told to skip it" do
        skip_details_for = [:fag]
        @kompetansemaal_celle_framviser.should_not_receive(:fag)
        @kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal.first, skip_details_for)
      end
      
      it "should not include kompetansemaalsett if it is told to skip it" do
        skip_details_for = [:kompetansemaalsett]
        @kompetansemaal_celle_framviser.should_not_receive(:kompetansemaalsett)
        @kompetansemaal_celle_framviser.send(:to_detail_html, @kompetansemaal.first, skip_details_for)
      end
      
    end
    
  end
  
  
  
  describe "sorting rows" do
    
    before :each do
      @kompetansemaal_celle_framviser = MyView.new
    end
    
    it "should be sorted by laereplan first" do
      plan_1 = Laereplan.new(:tittel => 'laereplan a')
      plan_2 = Laereplan.new(:tittel => 'laereplan b')
      hoved_1 = Hovedomraade.new(:tittel => 'hovedomraade', :laereplaner => [plan_1])
      hoved_2 = Hovedomraade.new(:tittel => 'hovedomraade', :laereplaner => [plan_2])
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [hoved_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [hoved_2])
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal x'
      sorted[1][2].should == 'maal a'
    end
    
    it "should be sorted by hovedomraade second" do
      plan_1 = Laereplan.new(:tittel => 'laereplan a')
      hoved_1 = Hovedomraade.new(:tittel => 'hovedomraade a', :laereplaner => [plan_1])
      hoved_2 = Hovedomraade.new(:tittel => 'hovedomraade b', :laereplaner => [plan_1])
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [hoved_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [hoved_2])
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal x'
      sorted[1][2].should == 'maal a'
    end
    
    it "should be sorted by kompetansemaalsett third" do
      plan_1 = Laereplan.new(:tittel => 'laereplan a')
      hoved_1 = Hovedomraade.new(:tittel => 'hovedomraade a', :laereplaner => [plan_1])
      sett_1 = Kompetansemaalsett.new(:tittel => 'sett a')
      sett_2 = Kompetansemaalsett.new(:tittel => 'sett b')
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [hoved_1], :kompetansemaalsett => [sett_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [hoved_1], :kompetansemaalsett => [sett_2])
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal x'
      sorted[1][2].should == 'maal a'
    end
    
    it "should be sorted by fag fourth" do
      plan_1 = Laereplan.new(:tittel => 'laereplan a')
      hoved_1 = Hovedomraade.new(:tittel => 'hovedomraade a', :laereplaner => [plan_1])
      fag_1 = Fag.new(:tittel => 'fag a')
      fag_2 = Fag.new(:tittel => 'fag b')
      sett_1 = Kompetansemaalsett.new(:tittel => 'sett', :fag => [fag_1])
      sett_2 = Kompetansemaalsett.new(:tittel => 'sett', :fag => [fag_2])
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [hoved_1], :kompetansemaalsett => [sett_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [hoved_1], :kompetansemaalsett => [sett_2])
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal x'
      sorted[1][2].should == 'maal a'
    end
    
    it "should be sorted by kompetansemaal finally" do
      plan_1 = Laereplan.new(:tittel => 'laereplan a')
      hoved_1 = Hovedomraade.new(:tittel => 'hovedomraade a', :laereplaner => [plan_1])
      fag_1 = Fag.new(:tittel => 'fag a')
      sett_1 = Kompetansemaalsett.new(:tittel => 'sett', :fag => [fag_1])
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [hoved_1], :kompetansemaalsett => [sett_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a', :hovedomraader => [hoved_1], :kompetansemaalsett => [sett_1])
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal a'
      sorted[1][2].should == 'maal x'
    end
    
    
    it "should have nil values sorted last " do
      hoved_1 = Hovedomraade.new(:tittel => 'hovedomraade a')
      maal_1 = Kompetansemaal.new(:tittel => 'maal x', :hovedomraader => [hoved_1])
      maal_2 = Kompetansemaal.new(:tittel => 'maal a')
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal)
      
      sorted[0][2].should == 'maal x'
      sorted[1][2].should == 'maal a'
    end
    
    it "should sort by kompetansemaal if the number of rows is higher than a maximum number of rows" do
      max_detailed_rows = 1
      
      maal_1 = Kompetansemaal.new(:tittel => 'maal a')
      maal_2 = Kompetansemaal.new(:tittel => 'maal b')
    
      kompetansemaal = [maal_2, maal_1]
      sorted = @kompetansemaal_celle_framviser.sorted_rows(kompetansemaal, [], max_detailed_rows)
      
      sorted[0][2].should == 'maal a'
      sorted[1][2].should == 'maal b'
    end
  end


  def strip_styling(tekst)
    tekst.gsub(/<[^>]+>/, "")
  end
  
  
end



