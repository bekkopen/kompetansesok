class LaereplansokController < ApplicationController

  def index
    @hovedomraader = create_options_for_select(Hovedomraade)
    @kompetansemaalsett = create_options_for_select(Kompetansemaalsett)
    @trinn = create_options_for_select(Trinn)

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
  
  
  private
  
  def create_options_for_select(klass)
    klass.find(:all).map do |k| 
      [k.tittel, k.uuid]
    end
  end


end
