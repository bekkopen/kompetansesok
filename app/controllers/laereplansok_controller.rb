class LaereplansokController < ApplicationController

  def index

    @hovedomraader = Hovedomraade.find(:all).map do |h|
      [h.tittel, h.uuid]
    end

    if not params[:laereplansok]
      @kompetansemaal = [].paginate
      @rader = [].paginate
    else
      @laereplansok = Laereplansok.new(params[:laereplansok].merge(:page => params[:page]))
      @kompetansemaal = @laereplansok.kompetansemaal
      @rader = @laereplansok.to_table_rows
    end

    
    render :action => "index"
  end


end
