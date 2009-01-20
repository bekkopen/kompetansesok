class LaereplanController < ApplicationController

  def show
    @laereplan = Laereplan.find_by_uuid(params[:id])
    @kompetansemaal_treff = @laereplan.kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel] }
  end

end
