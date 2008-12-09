require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kompetansemaal do
  before(:each) do
    @vaidattribute = {
      :tittel => "Kompetansemaaltittel",
      :uuid => "adfg"
    }
  end

  describe "validation" do
    it "should accept valid attributes" do
      @kompetansemaal = Kompetansemaal.create!(@validattribute)
    end

    it "should have unique uuid" do
      Kompetansemaal.create!(@valid_attributes)
      lambda do
        Kompetansemaal.create!(@valid_attributes)
      end.should raise_error
    end
  end

  describe "relationships" do
    before :each do
      @laereplan = Laereplan.new
      @kompetansemaalsett = Kompetansemaalsett.new
      @hovedomraade = Hovedomraade.new
      @kompetansemaal = Kompetansemaal.new
    end

    it "should have laereplan" do
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaalsett.laereplaner << @laereplan
      @kompetansemaal.laereplan.should == @laereplan
    end

    it "should have laereplan nil if kompetansemaalsett is nil" do
      @kompetansemaal.kompetansemaalsett.should be_empty
      @kompetansemaal.laereplan.should == nil
    end

    it "should have a list of kompetansemaalsett" do
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaal.kompetansemaalsett.length == 1
    end

    it "should have a list of hovedomraader" do
      @kompetansemaal.hovedomraader << @hovedomraade
      @kompetansemaal.hovedomraader.length == 1
    end

  end

  describe "infered attributes" do
    before :each do
      @laereplan = Laereplan.new
      @kompetansemaalsett = Kompetansemaalsett.new
      @hovedomraade = Hovedomraade.new
      @kompetansemaal = Kompetansemaal.new
    end

    it "should have laereplan_tittel" do
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaalsett.laereplaner << @laereplan
      @laereplan.tittel = "læreplantittel"
      @kompetansemaal.laereplan_tittel.should == "læreplantittel"
    end

    it "should have a blank laereplan_tittel if laereplan is nil" do
      @kompetansemaal.should_receive(:laereplan).and_return(nil)
      @kompetansemaal.laereplan_tittel.should == ""
    end

    it "should have kompetansemaalsett_tittel" do
      @kompetansemaalsett.tittel = "kompetansemålsettittel"
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaal.kompetansemaalsett_tittel.should == "kompetansemålsettittel"
    end

    it "should have a blank kompetansemaalsett_tittel if kompetansemaalsett is nil" do
      @kompetansemaal.should_receive(:kompetansemaalsett).and_return([])
      @kompetansemaal.kompetansemaalsett_tittel.should == ""
    end
    
    it "should have kompetansemaalsett_trinn" do
      @kompetansemaalsett.trinn = Trinn.new(:tittel => "trinntittel")
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaal.kompetansemaalsett_trinn.should == "trinntittel"
    end
    
    it "should have hovedomraade_tittel" do
      @hovedomraade.tittel = "hovedområdetittel"
      @kompetansemaal.hovedomraader << @hovedomraade
      @kompetansemaal.hovedomraade_tittel.should == "hovedområdetittel"
    end

    it "should have a blank kompetansemaalsett_tittel if kompetansemaalsett is nil" do
      @kompetansemaal.should_receive(:hovedomraader).and_return([])
      @kompetansemaal.hovedomraade_tittel.should == ""
    end

  end
end

