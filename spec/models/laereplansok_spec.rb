require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Laereplansok do
  
  describe "searching" do
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
      @laereplansok.kompetansemaal.length.should == 96
    end
    
    it "should allow '*' as a wildcard for 'match anything here'" do
      @laereplansok.laereplan_tittel = "aktivitetslære * idrettsfag"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 38
    end
  
    it "should be possible to search by laereplantittel" do
      @laereplansok.laereplan_tittel = "aktivitetslære - felles programfag i utdanningsprogram for idrettsfag"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 38
    end
    
    it "should be possible to search by a semicolon separated string of laereplankoder" do
      @laereplansok.laereplan_kode = "IDR1-01; AMM3"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 67
    end
    
    it "should be possible to search by a semicolon separated string of hovedomraadekoder" do
      @laereplansok.hovedomraade_kode = "Kode-1; Kode-a"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 31
    end
  
    it "should be possible to search by hovedomraade" do
      @laereplansok.hovedomraade = "uuid:78085ca0-5d55-4caa-a3b9-1bf54e720027"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 5
    end
  
    it "should be possible to search by kompetansemaalsett" do
      @laereplansok.kompetansemaalsett = "uuid:7ec420f8-6a1f-4dec-891d-4fd538ee2e8e"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 17
    end
  
    it "should be possible to search by trinn" do
      @laereplansok.trinn = "http://psi.udir.no/laereplan/aarstrinn/vg1"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 46
    end
  
    it "should be possible to search by kompetansemaaltittel" do
      @laereplansok.kompetansemaal_tittel = "anleggsmaskiner"
      kompetansemaal = @laereplansok.kompetansemaal
      kompetansemaal.length.should  == 2
    end
  end


  describe "generation of table rows" do
    before :each do
      @laereplansok = Laereplansok.new
      @laereplansok.stub!(:kompetansemaal).and_return([])
      @kompetansemaal = Kompetansemaal.new(:tittel => "måltittel")
    end
    
    it "should generate proper initalized array" do
      @laereplansok.to_table_rows.should be_empty
    end   

    it "should have two rows for a kompetansemål with two hovedområder" do
      hovedomraade1 = Hovedomraade.new(:tittel => "hovedområde 1")
      hovedomraade2 = Hovedomraade.new(:tittel => "hovedområde 2")
      @kompetansemaal.hovedomraader << [hovedomraade1, hovedomraade2]
    
      @laereplansok.should_receive(:kompetansemaal).and_return([@kompetansemaal])
      hovedomraade_titler = @laereplansok.to_table_rows.map {|row| row[1]}     
      hovedomraade_titler.compact.sort.should == ['hovedområde 1', 'hovedområde 2']
    end
    
    it "should have two rows for a kompetansemål with two kompetansemaalsett" do
      kompetansemaalsett1 = Kompetansemaalsett.new(:tittel => "kompetansemålsett 1")
      kompetansemaalsett2 = Kompetansemaalsett.new(:tittel => "kompetansemålsett 2")
      @kompetansemaal.kompetansemaalsett << [kompetansemaalsett1, kompetansemaalsett2]
      
      @laereplansok.should_receive(:kompetansemaal).and_return([@kompetansemaal])
      kompetansemaalsett_titler = @laereplansok.to_table_rows.map {|row| row[2]}        
      kompetansemaalsett_titler.sort.should == ['kompetansemålsett 1', 'kompetansemålsett 2']
    end
    
    it "should have two rows for a kompetansemål with a kompetansemålsett with two trinn" do
      trinn1 = Trinn.new(:tittel => "trinn 1")
      trinn2 = Trinn.new(:tittel => "trinn 2")
      kompetansemaalsett = Kompetansemaalsett.new(:trinn => [trinn1, trinn2])
      @kompetansemaal.kompetansemaalsett << [kompetansemaalsett]
      
      @laereplansok.should_receive(:kompetansemaal).and_return([@kompetansemaal])
      trinn_titler = @laereplansok.to_table_rows.map {|row| row[3]}        
      trinn_titler.sort.should == ['trinn 1', 'trinn 2']
    end
    
    it "should have two rows for a kompetansemål with a kompetansemålsett with two læreplaner" do
      laereplan1 = Laereplan.new(:tittel => "læreplan 1")
      laereplan2 = Laereplan.new(:tittel => "læreplan 2")
      kompetansemaalsett = Kompetansemaalsett.new(:laereplaner => [laereplan1, laereplan2])
      @kompetansemaal.kompetansemaalsett << [kompetansemaalsett]
      
      @laereplansok.should_receive(:kompetansemaal).and_return([@kompetansemaal])
      laereplan_titler = @laereplansok.to_table_rows.map {|row| row[0]}
      laereplan_titler.sort.should == ['læreplan 1', 'læreplan 2']
    end
    
    it "should have four rows for a kompetansemål with a kompetansemålsett with two trinn and two læreplaner" do
      trinn1 = Trinn.new(:tittel => "trinn 1")
      trinn2 = Trinn.new(:tittel => "trinn 2")
      laereplan1 = Laereplan.new(:tittel => "læreplan 1")
      laereplan2 = Laereplan.new(:tittel => "læreplan 2")
      kompetansemaalsett = Kompetansemaalsett.new(:laereplaner => [laereplan1, laereplan2], :trinn => [trinn1, trinn2])
      @kompetansemaal.kompetansemaalsett << [kompetansemaalsett]
      
      @laereplansok.should_receive(:kompetansemaal).and_return([@kompetansemaal])
      laereplan_trinn_titler = @laereplansok.to_table_rows.map {|row| [row[0], row[3]]}        
      laereplan_trinn_titler[0].should == ["læreplan 1", "trinn 1"]
      laereplan_trinn_titler[1].should == ["læreplan 2", "trinn 1"]
      laereplan_trinn_titler[2].should == ["læreplan 1", "trinn 2"]
      laereplan_trinn_titler[3].should == ["læreplan 2", "trinn 2"]
    end

  end

end
