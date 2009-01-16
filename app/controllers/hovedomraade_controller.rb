class HovedomraadeController < ApplicationController

  def show
    @hovedomraade = Hovedomraade.find_by_uuid(params[:id])
    @kompetansemaal_treff = @hovedomraade.kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel] }
  end

end
