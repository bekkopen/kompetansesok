class LaereplanController < ApplicationController

  def show
    @laereplan = Laereplan.find_by_uuid(params[:id])
    @kompetansemaal_treff = lag_kompetansemaalrader(@laereplan.kompetansemaal, :hovedomraade)
    @brodsmulesti = [@laereplan]
  end

end
