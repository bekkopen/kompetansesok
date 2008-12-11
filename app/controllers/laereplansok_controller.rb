class LaereplansokController < ApplicationController

  def index
    if not params[:laereplansok]
      @kompetansemaal = [].paginate
    else
      @laereplansok = Laereplansok.new :laereplan_tittel => params[:laereplansok][:laereplan_tittel], :page => params[:page]
      @kompetansemaal = @laereplansok.kompetansemaal
    end
  
    render :action => "index"
  end


end
