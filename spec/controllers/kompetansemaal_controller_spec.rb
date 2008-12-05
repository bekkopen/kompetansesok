require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KompetansemaalController do

  def mock_kompetansemaal(stubs={})
    @mock_kompetansemaal ||= mock_model(Kompetansemaal, stubs)
  end


end
