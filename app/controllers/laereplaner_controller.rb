class LaereplanerController < ApplicationController
  before_filter :find_all
  
  # GET /laereplaner
  # GET /laereplaner.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @laereplaner }
    end
  end
  
  def show
    @laereplan = Laereplan.find_by_uuid(params[:id])
    @kompetansemaal = @laereplan.kompetansemaal if @laereplan
  end


  private
  
  def find_all
    @laereplaner = Laereplan.find(:all)
  end
  
end
