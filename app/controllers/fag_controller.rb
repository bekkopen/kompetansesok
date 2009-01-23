class FagController < ApplicationController

  def show
    @fag = Fag.find_by_uuid(params[:id])
    @kompetansemaal_treff = lag_kompetansemaalrader(@fag.kompetansemaal, :kompetansemaalsett)
    @brodsmulesti = [@fag]
  end

end
