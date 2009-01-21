require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::KompetansemaalCelleFramviser do
  before(:each) do
    @stubs = {
      :laereplaner => [Laereplan.new(:tittel => "en"), Laereplan.new(:tittel => "to")],
      :hovedomraader => [Hovedomraade.new(:tittel => "h1"), Hovedomraade.new(:tittel => "h2")],
      :kompetansemaalsett => [Kompetansemaalsett.new(:tittel => "k1"), Kompetansemaalsett.new(:tittel => 'k2')],
      :fag => [Fag.new(:tittel => "f1"), Fag.new(:tittel => 'f2')],
      :t => 'i18n text'
    }

    @kompetansemaal = mock("Kompetansemaal",@stubs)
    @kompetansemaal_celle_framviser = Kompetansesok::KompetansemaalCelleFramviser.new(@kompetansemaal)
  end

  it "should return correct leareplan string" do
    @kompetansemaal_celle_framviser.laereplaner.should == "i18n text: en, to"
  end

  it "should return correct hovedomraade string" do
    @kompetansemaal_celle_framviser.hovedomraader.should == "i18n text: h1, h2"
  end

  it "should return correct Kompetansemaalsett string" do
    @kompetansemaal_celle_framviser.kompetansemaalsett.should == "i18n text: k1, k2"
  end

  it "should return correct fag string" do
    @kompetansemaal_celle_framviser.fag.should == "i18n text: f1, f2"
  end

  it "should produce correct html string" do
    @kompetansemaal_celle_framviser.to_html.should == "i18n text: en, to<br/>i18n text: h1, h2<br/>i18n text: k1, k2<br/>i18n text: f1, f2"
  end

  it "should produce correct html string, if no fag is present" do
    @stubs[:fag] = []
    
    @kompetansemaal_celle_framviser = Kompetansesok::KompetansemaalCelleFramviser.new(mock("kompetansemaal",  @stubs))
    @kompetansemaal_celle_framviser.to_html.should == "i18n text: en, to<br/>i18n text: h1, h2<br/>i18n text: k1, k2"
  end
end


