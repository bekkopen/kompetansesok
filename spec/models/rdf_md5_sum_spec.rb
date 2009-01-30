require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RdfMd5Sum do
  it "be able to hold current md5 sum value" do
    sum = "md5sumsomskalholdes"
    RdfMd5Sum.current = sum
      
    RdfMd5Sum.current.should == sum
  end

  it "should not make more than one row" do
    RdfMd5Sum.current = "test1"
    RdfMd5Sum.current = "test2"
    RdfMd5Sum.current = "test3"
    RdfMd5Sum.current = "test4"
    RdfMd5Sum.current = "test5"
    RdfMd5Sum.current.should == "test5"
    
    RdfMd5Sum.find(:all).size.should == 1
  end
end
