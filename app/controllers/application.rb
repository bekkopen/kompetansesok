# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Kompetansesok::KompetansemaalCelleFramviser
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '6e7a5576110f7718b17d0ea981c765f2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :set_spraak
  
  private
  
  def set_spraak
    session[:spraak].nil? ? I18n.locale = 'nb' : I18n.locale = session[:spraak]
  end
  
  def timestamp
    Time.now.strftime("%Y%m%d%H%M")
  end
  
  def lag_kompetansemaalrader(kompetansemaal)
    #TODO bruke configfil til å angi 30 i framtiden.
      if kompetansemaal.length <= 50
        kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel, "#{t.tittel.capitalize}<br/>#{to_detalje_html(t)}"] }
      else
        flash[:notice] = t('feilmelding.for_grovt_søk')
        kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel, t.tittel.capitalize] }
      end
  end
  
end
