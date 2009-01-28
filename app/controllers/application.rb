# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ApplicationHelper #helper all does not work
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '6e7a5576110f7718b17d0ea981c765f2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # vis_parameter_logging :password
  
  before_filter :set_spraak
  
  private
  
  def set_spraak
    session[:spraak].nil? ? I18n.locale = 'nb' : I18n.locale = session[:spraak]
  end
  
  def timestamp
    Time.now.strftime("%Y%m%d%H%M")
  end

  def lag_kompetansemaalrader(kompetansemaal, ikke_vis_detaljer_for = [], begrens_antall_detaljrader = false)
    maks_detalj_rader = if begrens_antall_detaljrader
      Udir::CONFIG['maks_detalj_rader'] 
    else
      nil
    end
    
    if maks_detalj_rader && kompetansemaal.length > maks_detalj_rader
      flash[:sok_tilbakemelding] = t('feilmelding.for_grovt_søk')
    end
    sorted_rows(kompetansemaal, ikke_vis_detaljer_for, maks_detalj_rader)
  end  
  
end
