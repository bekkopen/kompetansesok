class KompetansemaalsettController < ApplicationController

  def show
    @kompetansemaalsett = Kompetansemaalsett.find_by_uuid(params[:id])
    
    kompetansemaal = if params[:hovedomraade_id]
      @kompetansemaalsett.kompetansemaal_for_hovedomraade(Hovedomraade.find_by_uuid(params[:hovedomraade_id]))
    else
      @kompetansemaalsett.kompetansemaal
    end

    @kompetansemaal_treff = kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel] }
  end

end