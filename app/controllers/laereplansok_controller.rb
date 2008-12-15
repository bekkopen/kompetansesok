class LaereplansokController < ApplicationController

  def index

    @hovedomraader = Hovedomraade.find(:all).map {|h| [h.tittel, h.uuid] }
    @kompetansemaalsett = Kompetansemaalsett.find(:all).map {|maalsett| [maalsett.tittel, maalsett.uuid] }
    @trinn = Trinn.find(:all).map {|trinn| [trinn.tittel, trinn.uuid] }

    if params[:laereplansok]
      @laereplansok = Laereplansok.new(params[:laereplansok].merge(:page => params[:page]))
      @kompetansemaal = @laereplansok.kompetansemaal
      @rader = @laereplansok.to_table_rows
      render :action => "index"
    else
      @kompetansemaal = [].paginate
      @rader = [].paginate
    end

  end


end
