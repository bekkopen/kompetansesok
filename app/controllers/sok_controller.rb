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

  def download_csv

    response.headers['Content-Type'] = 'application/force-download'

    valgte_kompetanse_maal = []
    if params[:uuids]
      params[:uuids].split(",").each do |uuid|
        kompetansemaal = Kompetansemaal.find_by_uuid(uuid)
        if kompetansemaal
          valgte_kompetanse_maal << kompetansemaal
        end
      end
    end
    
    @content = FasterCSV.generate do |csv|
      valgte_kompetanse_maal.each do |k|
        values = fetch_values(params, k)
        csv << values unless values.empty?
      end
    end

    render :layout => false
  end

  private

  def fetch_values(options, kompetansemaal)
    values =[]
    if options["showId"] == "on"
      values << kompetansemaal.uuid
    end
    if options["showKode"] == "on"
      values << kompetansemaal.kode
    end
    if options["showPsi"] == "on"
      values << kompetansemaal.psi
    end
    values
  end

end