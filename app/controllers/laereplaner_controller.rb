class LaereplanerController < ApplicationController
  # GET /laereplaner
  # GET /laereplaner.xml
  def index
    @laereplaner = Laereplan.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @laereplaner }
    end
  end

  
end
