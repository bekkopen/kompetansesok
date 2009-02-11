require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Kompetansesok::CsvGenerator do
  before(:each) do
    @generator = Kompetansesok::CsvGenerator.new
  end
  
  it "should generate csv" do
    Kompetansesok::KompetansemaalRad.should_receive(:header_row).and_return(['head_one', 'head_two']) 
    @generator.should_receive(:rows_for).with('some-uuids').and_return([['one', 'two'], ['three', 'four']])
    @generator.csv_for('some-uuids').should == "head_one,head_two\none,two\nthree,four\n"
  end
  
  it "should find kompetansemaal from a list of uuids" do
    uuids = 'uuid-1,uuid-2'
    Kompetansemaal.should_receive(:find_by_uuid).with('uuid-1').and_return(Kompetansemaal.new)
    Kompetansemaal.should_receive(:find_by_uuid).with('uuid-2').and_return(Kompetansemaal.new)
    
    @generator.send(:rows_for, uuids)
  end
     
  describe "rows" do
    before :each do
      @maal = Kompetansemaal.new(:uuid => 'maal_uuid')
      Kompetansemaal.should_receive(:find_by_uuid).with('maal_uuid').and_return(@maal)
    end
        
    describe "through laereplan" do
      before :each do
        @laereplan = Laereplan.new
        @hoved = Hovedomraade.new(:laereplaner => [@laereplan])
        @sett = Kompetansemaalsett.new(:laereplaner => [@laereplan])
        @laereplan.hovedomraader << @hoved
        @laereplan.kompetansemaalsett << @sett
        @hoved.kompetansemaal << @maal
        @sett.kompetansemaal << @maal
        @maal.hovedomraader << @hoved
        @maal.kompetansemaalsett << @sett
      end

      describe "with kompetansemaal info" do
   
        it "should have kompetansemaal.uuid" do
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[0].should == 'maal_uuid'
        end
    
        it "should have kompetansemaal.kode" do
          @maal.kode = 'maal_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[1].should == 'maal_kode'
        end
    
        it "should have kompetansemaal.tittel" do
          @maal.tittel = 'maal_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[2].should == 'maal_tittel'
        end
      end
    
      describe "with laereplan info" do      
        it "should have one row for each laereplan" do
          laereplan_2 = Laereplan.new
          @hoved.laereplaner << laereplan_2
          laereplan_2.hovedomraader << @hoved
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.length.should == 2
        end
      
        it "should have laereplan.uuid" do
          @laereplan.uuid = 'laereplan_uuid'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[3].should == 'laereplan_uuid'
        end
    
        it "should have laereplan.kode" do
          @laereplan.kode = 'laereplan_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[4].should == 'laereplan_kode'
        end
    
        it "should have laereplan.tittel" do
          @laereplan.tittel = 'laereplan_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[5].should == 'laereplan_tittel'
        end 
      end
    

      describe "with hovedomraade info" do
      
        it "should have one row for each hovedomraade" do
          @maal.hovedomraader << Hovedomraade.new(:kompetansemaal => [@maal], :laereplaner => [@laereplan])
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.length.should == 2
        end
      
        it "should have hovedomraade.uuid" do
          @hoved.uuid = 'hoved_uuid'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[6].should == 'hoved_uuid'
        end
    
        it "should have hovedomraade.kode" do
          @hoved.kode = 'hoved_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[7].should == 'hoved_kode'
        end
    
        it "should have hovedomraade.tittel" do
          @hoved.tittel = 'hoved_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[8].should == 'hoved_tittel'
        end   
      end
      
    
      describe "with kompetansemaalsett info" do
            
        it "should have one row for each kompetansemaalsett" do
          @maal.kompetansemaalsett << Kompetansemaalsett.new(:laereplaner => [@laereplan])
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.length.should == 2
        end
            
        it "should have kompetansemaalsett.uuid" do
          @sett.uuid = 'sett_uuid'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[9].should == 'sett_uuid'
        end
          
        it "should have kompetansemaalsett.kode" do
          @sett.kode = 'sett_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[10].should == 'sett_kode'
        end
          
        it "should have kompetansemaalsett.tittel" do
          @sett.tittel = 'sett_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[11].should == 'sett_tittel'
        end
      end

    end
    
    
    describe "through fag" do
      before :each do
        @fag = Fag.new
        @sett = Kompetansemaalsett.new(:fag => [@fag])
        @fag.kompetansemaalsett << @sett
        @sett.kompetansemaal << @maal
        @maal.kompetansemaalsett << @sett
      end 
      
      describe "with kompetansemaal info" do
   
        it "should have kompetansemaal.uuid" do
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[0].should == 'maal_uuid'
        end
    
        it "should have kompetansemaal.kode" do
          @maal.kode = 'maal_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[1].should == 'maal_kode'
        end
    
        it "should have kompetansemaal.tittel" do
          @maal.tittel = 'maal_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[2].should == 'maal_tittel'
        end
      end
      
      
      describe "with fag info" do      
        it "should have one row for each fag" do
          fag_2 = Fag.new
          @sett.fag << fag_2
          fag_2.kompetansemaalsett << @sett
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.length.should == 2
        end
        
        it "should have fag.uuid" do
          @fag.uuid = 'fag_uuid'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[12].should == 'fag_uuid'
        end
        
        it "should have fag.kode" do
          @fag.kode = 'fag_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[13].should == 'fag_kode'
        end
        
        it "should have fag.tittel" do
          @fag.tittel = 'fag_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[14].should == 'fag_tittel'
        end 
      end
      
      describe "with kompetansemaalsett info" do
            
        it "should have one row for each kompetansemaalsett" do
          sett_2 = Kompetansemaalsett.new(:fag => [@fag])
          @maal.kompetansemaalsett << sett_2
          @fag.kompetansemaalsett << sett_2
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.length.should == 2
        end
            
        it "should have kompetansemaalsett.uuid" do
          @sett.uuid = 'sett_uuid'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[9].should == 'sett_uuid'
        end
          
        it "should have kompetansemaalsett.kode" do
          @sett.kode = 'sett_kode'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[10].should == 'sett_kode'
        end
          
        it "should have kompetansemaalsett.tittel" do
          @sett.tittel = 'sett_tittel'
          rows = @generator.send(:rows_for, 'maal_uuid')
          rows.first[11].should == 'sett_tittel'
        end
      end
      
      
      
    end
    
  end

end
