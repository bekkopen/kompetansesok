class LaereplanController < ApplicationController

  def show
    
    @laereplan = Laereplan.find_by_uuid(params[:id])
    if @laereplan == nil
      flash[:error] = t('feilmelding.ingen_slik_laereplan')
    else
      @brodsmulesti = lag_brodsmuler([@laereplan])
      @kompetansemaal_treff = lag_kompetansemaalrader(@laereplan.kompetansemaal, [@laereplan])
    end
  end

end
