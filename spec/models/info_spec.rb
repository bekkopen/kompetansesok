require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Info do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Info.create!(@valid_attributes)
  end
  
  describe "statistics" do
    
    before :each do
      today = Info.new(:created_at => Time.today)     
      start_of_this_week = Info.new(:created_at => Time.today.beginning_of_week)
      end_of_last_week = Info.new(:created_at => Time.today.beginning_of_week.yesterday)
      start_of_last_week = Info.new(:created_at => Time.today.beginning_of_week.yesterday.beginning_of_week)
      start_of_this_month = Info.new(:created_at => Time.today.beginning_of_month)
      last_month = Info.new(:created_at => Time.today.last_month)
      start_of_last_month = Info.new(:created_at => Time.today.last_month.beginning_of_month)
      
      infos = [today, start_of_this_week, end_of_last_week, start_of_last_week, start_of_this_month, last_month, start_of_last_month]
      
      Info.should_receive(:find).with(:all, :conditions => "created_at >= #{Time.today.last_month.beginning_of_month.to_date}").and_return(infos)
    end
    
    
    it "should have number of searches this week" do           
      Info.sok_statistikk[:denne_uke].should == 2
    end
    
    it "should have number of searches last week" do
      Info.sok_statistikk[:forrige_uke].should == 2
    end
    
    it "should have number of searches this month" do
      Info.sok_statistikk[:denne_maaned].should == 5
    end
    
    it "should have number of searches last month" do
      Info.sok_statistikk[:forrige_maaned].should == 2
    end
    
  end
end
