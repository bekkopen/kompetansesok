class SokController < ApplicationController

  def index
    if params[:q].blank?
      @kompetansemaal_treff = []
      if params.has_key?(:q)
        flash[:notice] = t('meldinger.angi_kriterium')
      end
    else
      flash.delete(:notice)
      sok = Ultrasphinx::Search.new(:query => params[:q])
      treff = sok.run
      
      kompetansemaal_treff = treff
      
      @kompetansemaal_treff = kompetansemaal_treff.map{|t| t.tittel } 
      
      
    end
  end

end
