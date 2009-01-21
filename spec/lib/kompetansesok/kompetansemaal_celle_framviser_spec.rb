require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::KompetansemaalCelleFramviser do
  class MyView
    include Kompetansesok::KompetansemaalCelleFramviser
    def t(key)
      key
    end
  end

  before(:each) do
    @stubs = {
      :laereplaner => [Laereplan.new(:tittel => "en"), Laereplan.new(:tittel => "to")],
      :hovedomraader => [Hovedomraade.new(:tittel => "h1"), Hovedomraade.new(:tittel => "h2")],
      :kompetansemaalsett => [Kompetansemaalsett.new(:tittel => "k1"), Kompetansemaalsett.new(:tittel => 'k2')],
      :fag => [Fag.new(:tittel => "f1"), Fag.new(:tittel => 'f2')]
    }

    @kompetansemaal = mock("Kompetansemaal",@stubs)
    @kompetansemaal_celle_framviser = MyView.new
  end

  it "should return correct leareplan string" do
    @kompetansemaal_celle_framviser.laereplaner(@kompetansemaal).should == "etiketter.læreplan: en, to"
  end

  it "should return correct hovedomraade string" do
    @kompetansemaal_celle_framviser.hovedomraader(@kompetansemaal).should == "etiketter.hovedområde: h1, h2"
  end

  it "should return correct Kompetansemaalsett string" do
    @kompetansemaal_celle_framviser.kompetansemaalsett(@kompetansemaal).should == "etiketter.kompetansemålsett: k1, k2"
  end

  it "should return correct fag string" do
    @kompetansemaal_celle_framviser.fag(@kompetansemaal).should == "etiketter.fag: f1, f2"
  end

  it "should produce correct html string" do
    @kompetansemaal_celle_framviser.to_html(@kompetansemaal).should == "etiketter.læreplan: en, to<br/>etiketter.hovedområde: h1, h2<br/>etiketter.kompetansemålsett: k1, k2<br/>etiketter.fag: f1, f2"
  end

  it "should produce correct html string, if no fag is present" do
    @stubs[:fag] = []
    @kompetansemaal = (mock("kompetansemaal",  @stubs))
    @kompetansemaal_celle_framviser = MyView.new 
    @kompetansemaal_celle_framviser.to_html(@kompetansemaal).should == "etiketter.læreplan: en, to<br/>etiketter.hovedområde: h1, h2<br/>etiketter.kompetansemålsett: k1, k2"
  end
end


