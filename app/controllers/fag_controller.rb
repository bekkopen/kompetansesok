class FagController < ApplicationController

  def show
    @fag = Fag.find_by_uuid(params[:id])
    @brodsmulesti = lag_brodsmuler([@fag])
    @kompetansemaal_treff = lag_kompetansemaalrader(@fag.kompetansemaal, [@fag])  
  end

end
