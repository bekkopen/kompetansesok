class SokController < ApplicationController
  before_filter :set_standard_filtering

  def index
    @kompetansemaal_treff = []
    @laereplaner_treff = []
    @hovedomraader_treff = []
    @kompetansemaalsett_treff = []
    @fag_treff = []

    %w{filter_kompetansemaal filter_laereplaner filter_hovedomraader filter_kompetansemaalsett filter_fag}.each do |p|
      session[p] = params[p] if params.has_key?(p)
    end
    
    if params[:q].blank?     
      if params.has_key?(:q)
        flash[:notice] = t('meldinger.angi_kriterium')
      end
    else
      flash.delete(:notice)
      sokestreng = params[:q].gsub(';', ' or ')
      sok = Ultrasphinx::Search.new(:query => sokestreng, :per_page => Ultrasphinx::Search::MAX_MATCHES)
      treff = sok.run
      
      kompetansemaal, @laereplaner_treff, @hovedomraader_treff, @kompetansemaalsett_treff, @fag_treff = 
        partition_by_class(treff, Kompetansemaal, Laereplan, Hovedomraade, Kompetansemaalsett, Fag)       

      @kompetansemaal_treff = lag_kompetansemaalrader(kompetansemaal, :laereplan)
    end
  end

  def download_csv

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
    
    send_data(@content, :filename => "#{timestamp}_kompetansemaal.csv", :disposition => 'inline')

  end

  private
  
  def partition_by_class(mixed_array, *klasses)
    klasses.map do |klass|
      klass_result, rest = mixed_array.partition do |mixed_element|
        mixed_element.instance_of? klass
      end
      klass_result.flatten
    end
  end

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

  def set_standard_filtering
    %w{filter_kompetansemaal filter_laereplaner filter_hovedomraader filter_kompetansemaalsett filter_fag}.each do |p|
      session[p] = "true" unless session.cgi.has_key?(p) rescue nil # Ingen cgi i spec miljø
    end
  end

end
