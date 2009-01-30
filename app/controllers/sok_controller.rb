class SokController < ApplicationController
  before_filter :set_standard_filtering

  def index
    @kompetansemaal_treff = []
    @laereplaner_treff = []
    @hovedomraader_treff = []
    @kompetansemaalsett_treff = []
    @fag_treff = []

    %w{vis_kompetansemaal vis_laereplaner vis_hovedomraader vis_kompetansemaalsett vis_fag}.each do |p|
      session[p] = params[p] if params.has_key?(p)
    end
    
    if params[:q].blank?     
      if params.has_key?(:q)
        flash[:sok_tilbakemelding] = t('meldinger.angi_kriterium')
      end
    else
      Info.create #uset to generate statistics of number of searches performed
      
      flash.delete(:sok_tilbakemelding)
      sokestreng = params[:q].gsub(';', ' or ')
      sok = Ultrasphinx::Search.new(:query => sokestreng, :per_page => Ultrasphinx::Search::MAX_MATCHES)
      treff = sok.run
      
      kompetansemaal, @laereplaner_treff, @hovedomraader_treff, @kompetansemaalsett_treff, @fag_treff = 
        partition_by_class(treff, Kompetansemaal, Laereplan, Hovedomraade, Kompetansemaalsett, Fag)       

      @kompetansemaal_treff = lag_kompetansemaalrader(kompetansemaal, [], true) if params[:vis_kompetansemaal] == 'true'

    end
  end

  def download_csv
    @content =  Kompetansesok::CsvGenerator.new.csv_for(params[:uuids])  
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

  def set_standard_filtering
    %w{vis_kompetansemaal vis_laereplaner vis_hovedomraader vis_kompetansemaalsett vis_fag}.each do |p|
      session[p] = "true" unless session.cgi.has_key?(p) rescue nil # Ingen cgi i spec miljø
    end
  end

end
