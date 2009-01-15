class SokController < ApplicationController

  def index
    @kompetansemaal_treff = []
    @laereplan_treff = []
    @hovedomraade_treff = []
    
    if params[:q].blank?     
      if params.has_key?(:q)
        flash[:notice] = t('meldinger.angi_kriterium')
      end
    else
      flash.delete(:notice)
      sok = Ultrasphinx::Search.new(:query => params[:q])
      treff = sok.run
      
      treff.each do |t|
        if t.instance_of? Kompetansemaal
          @kompetansemaal_treff << t
        elsif t.instance_of? Laereplan
          @laereplan_treff << t
        elsif t.instance_of? Hovedomraade
          @hovedomraade_treff << t
        end
      end
            
      @kompetansemaal_treff = @kompetansemaal_treff.map{|t| [t.uuid, t.kode, t.tittel] }       
    end
  end

end
