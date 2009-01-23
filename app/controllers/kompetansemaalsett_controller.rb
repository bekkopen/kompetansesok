class KompetansemaalsettController < ApplicationController

  def show
    @kompetansemaalsett = Kompetansemaalsett.find_by_uuid(params[:id])
    @brodsmulesti =[]
    legg_laereplan_i_brodsmulesti()
    legg_fag_i_brodsmulesti()

    if params[:hovedomraade_id]
      hovedomraade = Hovedomraade.find_by_uuid(params[:hovedomraade_id])
      kompetansemaal = @kompetansemaalsett.kompetansemaal_for_hovedomraade(hovedomraade)
      @brodsmulesti << hovedomraade
    else
      kompetansemaal = @kompetansemaalsett.kompetansemaal
    end
    
    @brodsmulesti << @kompetansemaalsett
    @brodsmulesti = @brodsmulesti.flatten
    @kompetansemaal_treff = lag_kompetansemaalrader(kompetansemaal)
  end

  private
  def legg_laereplan_i_brodsmulesti
    if params[:laereplan_id]
      laereplan = Laereplan.find_by_uuid(params[:laereplan_id])
      @brodsmulesti << laereplan
    end
  end

  def legg_fag_i_brodsmulesti
    if params[:fag_id]
      fag = Fag.find_by_uuid(params[:fag_id])
      @brodsmulesti << fag
    end
  end

end