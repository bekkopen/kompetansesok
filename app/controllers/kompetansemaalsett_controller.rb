class KompetansemaalsettController < ApplicationController

  def show
    @kompetansemaalsett = Kompetansemaalsett.find_by_uuid(params[:id])
    
    if params[:hovedomraade_id]
      kompetansemaal = @kompetansemaalsett.kompetansemaal_for_hovedomraade(Hovedomraade.find_by_uuid(params[:hovedomraade_id]))
    else
      kompetansemaal = @kompetansemaalsett.kompetansemaal
    end

    @kompetansemaal_treff = lag_kompetansemaalrader(kompetansemaal)
  end

end