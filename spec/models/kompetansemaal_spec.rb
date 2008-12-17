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

    it "should have a list of kompetansemaalsett" do
      @kompetansemaal.kompetansemaalsett << @kompetansemaalsett
      @kompetansemaal.kompetansemaalsett.length == 1
    end

    it "should have a list of hovedomraader" do
      @kompetansemaal.hovedomraader << @hovedomraade
      @kompetansemaal.hovedomraader.length == 1
    end

  end
  
end

