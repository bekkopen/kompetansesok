class HovedomraadeController < ApplicationController

  def show
    @hovedomraade = Hovedomraade.find_by_uuid(params[:id])
    
    if params[:laereplan_id]
      @laereplan = Laereplan.find_by_uuid(params[:laereplan_id])
      kompetansemaal = @hovedomraade.kompetansemaal_for_laereplan(@laereplan)
      @kompetansemaalsett = @hovedomraade.kompetansemaalsett_for_laereplan(@laereplan)
      @through_laereplan = true
      brodsmule_elementer = [@laereplan, @hovedomraade]
    else
      kompetansemaal = @hovedomraade.kompetansemaal
      @kompetansemaalsett = @hovedomraade.kompetansemaalsett
      brodsmule_elementer = [@hovedomraade]
    end

    @brodsmulesti = lag_brodsmuler(brodsmule_elementer.compact)
    @kompetansemaal_treff = lag_kompetansemaalrader(kompetansemaal, :kompetansemaalsett)
  end

end
