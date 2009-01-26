class LaereplanController < ApplicationController

  def show
    @laereplan = Laereplan.find_by_uuid(params[:id])
    @brodsmulesti = lag_brodsmuler([@laereplan])
    @kompetansemaal_treff = lag_kompetansemaalrader(@laereplan.kompetansemaal, :hovedomraade)
  end

end
