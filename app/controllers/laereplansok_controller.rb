class LaereplansokController < ApplicationController

  def index

    @hovedomraader = Hovedomraade.find(:all).map do |h|
      [h.tittel, h.uuid]
    end
    
    @kompetansemaalsett = Kompetansemaalsett.find(:all).map do |maalsett|
      [maalsett.tittel, maalsett.uuid]
    end
    
    @trinn = Trinn.find(:all).map do |trinn|
      [trinn.tittel, trinn.uuid]
    end

    if not params[:laereplansok]
      @kompetansemaal = [].paginate
    else
      @laereplansok = Laereplansok.new(params[:laereplansok].merge(:page => params[:page]))
      @kompetansemaal = @laereplansok.kompetansemaal
      render :action => "index"
    end

  end


end
