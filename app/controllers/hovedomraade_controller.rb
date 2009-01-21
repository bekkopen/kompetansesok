class HovedomraadeController < ApplicationController

  def show
    @hovedomraade = Hovedomraade.find_by_uuid(params[:id])
    
    kompetansemaal = if params[:laereplan_id]
      @hovedomraade.kompetansemaal_for_laereplan(Laereplan.find_by_uuid(params[:laereplan_id]))
    else
      @hovedomraade.kompetansemaal
    end
    
    @kompetansemaal_treff = kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel] }
    
  end

end
