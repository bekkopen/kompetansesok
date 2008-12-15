require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Laereplansok do
  before :all do 
    importerer = Kompetansesok::Importerer.new(Rails.root + '/spec/rdf')
    importerer.importer_til_db
  end
  
  before :each do
    @laereplansok = Laereplansok.new
    @laereplansok.instance_variable_set(:@per_page,  100000)
  end
  
  it "should return nothing if there is a no matching laereplantittel" do
    @laereplansok.laereplan_tittel = "asdfasdfasdf"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.should be_empty
  end

  it "should return all records when no search parameters are given" do
    @laereplansok.kompetansemaal.length.should == 67
  end
  
  it "should be possible to search by laereplantittel" do
    @laereplansok.laereplan_tittel = "aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.length.should  == 38
  end
  
  it "should be possible to search by laereplankode" do
    @laereplansok.laereplan_kode = "IDR1-01"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.length.should  == 38
  end
  
  it "should be possible to search by hovedomraade" do
    @laereplansok.hovedomraade = "uuid:78085ca0-5d55-4caa-a3b9-1bf54e720027"
    kompetansemaal = @laereplansok.kompetansemaal
    kompetansemaal.length.should  == 5
  end


  describe "generation of table rows" do
    it "should generate proper initalized array" do
      @laereplansok.to_table_rows.should_not be_empty
      @laereplansok.to_table_rows.first.should_not be_empty
    end

    it "should not contain equal rows" do
      seen_rows = []
      @laereplansok.to_table_rows.each do |row|
        seen_rows << row.to_s
      end

      seen_rows.length.should == seen_rows.uniq.length
    end

    it "should generate multiple rows upon more than one trinn" do
      create_controled_structure()

      seen = 0
      @laereplansok.to_table_rows.each do |row|
        if row[2] == Kompetansemaalsett.find(:first).tittel
          seen += 1
        end
      end
      seen.should == 2

    end

  end


  def create_controled_structure
    Trinn.find(:all).each do |t|
      t.destroy
    end
    Kompetansemaalsett.find(:all).each do |k|
      k.destroy
    end

    kompetansemaalsett = Kompetansemaalsett.create
    kompetansemaalsett.kompetansemaal = [Kompetansemaal.create(:tittel => "kompetansemaal tittel")]
    kompetansemaalsett.laereplaner = [Laereplan.create(:tittel => "laereplan tittel")]
    kompetansemaalsett.tittel = "kompetansemaalsett tittel"
    trinn = Trinn.create :tittel => "trinn tittel"
    trinn.kompetansemaalsett << kompetansemaalsett
    kompetansemaalsett.trinn << trinn
    kompetansemaalsett.save!
    trinn.save!
  end


end
