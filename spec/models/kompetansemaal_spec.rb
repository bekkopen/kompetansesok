require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kompetansemaal do
  before(:each) do
    @vaidattribute = {
      :tittel => "Kompetanse maal tittel",
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

    it "should have kompetansemaalsett" do
      @kompetansemaal.kompetansemaalsett.should be_empty
    end

    it "should have a list of kompetansemaalsett" do
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaal.kompetansemaalsett.length == 1
    end

  end

  describe "infered attributes" do
    before :each do
      @laereplan = Laereplan.new
      @kompetansemaalsett = Kompetansemaalsett.new
      @kompetansemaal = Kompetansemaal.new
    end

    it "should have laereplan_tittel from laereplan" do
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaalsett.laereplaner << @laereplan
      @laereplan.tittel = "tittel"
      @kompetansemaal.laereplan_tittel.should == "tittel"
    end

    it "should have a blank laereplan_tittel if laereplan is nil" do
      @kompetansemaal.should_receive(:laereplan).and_return(nil)
      @kompetansemaal.laereplan_tittel.should == ""
    end

    it "should have kompetansemaalsett_tittel from kompetansemaalsett" do
      @kompetansemaalsett.tittel = "kompetansemaalsett tittel"
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaal.kompetansemaalsett_tittel.should == "kompetansemaalsett tittel"
    end

    it "should have a blank kompetansemaalsett_tittel if kompetansemaalsett is nil" do
      @kompetansemaal.should_receive(:kompetansemaalsett).and_return([])
      @kompetansemaal.kompetansemaalsett_tittel.should == ""
    end

  end
end

