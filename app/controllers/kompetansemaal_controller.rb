class KompetansemaalController < ApplicationController
  # GET /kompetansemaal
  # GET /kompetansemaal.xml
  def index
    @kompetansemaal = Kompetansemaal.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kompetansemaal }
    end
  end
  
end
