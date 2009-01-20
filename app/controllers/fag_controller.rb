class FagController < ApplicationController

  def show
    @fag = Fag.find_by_uuid(params[:id])
    @kompetansemaal_treff = @fag.kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel] }
  end

end
