require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DbDumpsController do
  before(:each) do
    @tmp_db_dumps_dir = "tmp/db_dumps_test"
    if not File.exist?(@tmp_db_dumps_dir)
      File.makedirs(@tmp_db_dumps_dir)
    end
    controller.should_receive(:udir_config).and_return({"db_dumps"=>{"path"=>@tmp_db_dumps_dir}})
  end

  after(:each) do
    dir = Dir.open(@tmp_db_dumps_dir)
    while file = dir.read
      file_path = File.join(@tmp_db_dumps_dir, file)
      if File.file?(file_path)
        File.delete(file_path)
      end
    end
  end

  it "should give a empty list if no files are in db_dump dir" do
    get :index
    assigns[:db_dumps].should be_empty
  end

  it "should give a list of files, corresponding to the files in the directory" do
    make_two_files
    
    get :index
    assigns[:db_dumps].should == {
      "db_dump_test1.zip" => File.join("db_dumps_test", "db_dump_test1.zip"),
      "db_dump_test2.zip" => File.join("db_dumps_test", "db_dump_test2.zip")
    }
  end

  def make_two_files
    File.open(File.join(@tmp_db_dumps_dir, "db_dump_test1.zip"), 'w') do |f| f.puts "test" end
    File.open(File.join(@tmp_db_dumps_dir, "db_dump_test2.zip"), 'w') do |f| f.puts "test" end
  end

  it "should only give out dumps that are well formed" do
    make_two_files
    File.open(File.join(@tmp_db_dumps_dir, "tulle_file.zip"), 'w') do |f| f.puts "tull" end

    get :index
    assigns[:db_dumps].should == {
      "db_dump_test1.zip" => File.join("db_dumps_test", "db_dump_test1.zip"),
      "db_dump_test2.zip" => File.join("db_dumps_test", "db_dump_test2.zip")
    }
  end

end
