class HovedomraadeController < ApplicationController

  def show
    @hovedomraade = Hovedomraade.find_by_uuid(params[:id])
    
    if params[:laereplan_id]
      @laereplan = Laereplan.find_by_uuid(params[:laereplan_id])
      kompetansemaal = @hovedomraade.kompetansemaal_for_laereplan(@laereplan)
      @kompetansemaalsett = @hovedomraade.kompetansemaalsett_for_laereplan(@laereplan)
      @through_laereplan = true
      @brodsmulesti = [@laereplan, @hovedomraade]
    else
      kompetansemaal = @hovedomraade.kompetansemaal
      @kompetansemaalsett = @hovedomraade.kompetansemaalsett
      @brodsmulesti = [@hovedomraade]
    end

    @kompetansemaal_treff = lag_kompetansemaalrader(kompetansemaal, :kompetansemaalsett)
  end

end
