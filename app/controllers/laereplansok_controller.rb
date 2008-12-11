class LaereplansokController < ApplicationController

  def index
    if not params[:laereplansok]
      @kompetansemaal = [].paginate
    else
      @laereplansok = Laereplansok.new(params[:laereplansok].merge(:page => params[:page]))
      @kompetansemaal = @laereplansok.kompetansemaal
    end
  
    render :action => "index"
  end


end
