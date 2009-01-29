# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Kompetansesok::KompetansemaalCelleFramviser

  def lag_brodsmuler(elementer)
    if not elementer.empty?
      elementer.map do |element|
        {
          :klasse     => element.class, 
          :ikon_tekst => element.ikon_tekst, 
          :tittel     => element.tittel, 
          :url        => lag_path_for(element, elementer)
        }
      end
    end
  end

  def lag_path_for(element, elementer)
    hvilke = []

    elementer.each do |kandidat|
      hvilke << kandidat
      if kandidat == element
        return generate_path(hvilke)
      end
    end
    raise "Feil bruk at lag_path_for, element må eksistere i elimenter"
  end

  def generate_path(elementer)
    if elementer.empty?    
      ""
    else
      klasser = elementer.map do |e|
        e.class.to_s.downcase
      end
      uuids = elementer.map do |e|
        e.uuid
      end
      
      send(klasser.join("_") + "_path", *uuids)
    end
  end
  
  def current_page_sok?
    %w{sok fag hovedomraade kompetansemaalsett laereplan bla_i_laereplan}.index(params[:controller].to_s)
  end

  def session_checked?(key)
    session[key] == "true"
  end
end
