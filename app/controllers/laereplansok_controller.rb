class LaereplansokController < ApplicationController

  def index
    @hovedomraader_options = create_options_for_select(Hovedomraade)
    @kompetansemaalsett_options = create_options_for_select(Kompetansemaalsett)
    @trinn_options = create_options_for_select(Trinn)

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

  def dropdown_content 
    laereplaner_sok = Laereplansok.new(params[:laereplansok])
    @kompetansemaalsett_options = laereplaner_sok.kompetansemaalsett.map do |sett|
      [sett.uuid, sett.tittel]
    end
    @trinn_options = laereplaner_sok.trinn.map do |trinn|
      [trinn.uuid, trinn.tittel]
    end
    prepend_empty_option(@kompetansemaalsett_options)
    prepend_empty_option(@trinn_options)     
  end

  
  private
 
  def create_options_for_select(klass)
    klass.find(:all).map do |k| 
      [k.tittel, k.uuid]
    end
  end
  
  def prepend_empty_option(options_array)
    options_array.unshift([])  
  end


end
