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

  # GET /laereplaner/1
  # GET /laereplaner/1.xml
  def show
    @laereplan = Laereplan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @laereplan }
    end
  end

end
