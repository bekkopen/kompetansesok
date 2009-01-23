# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Kompetansesok::KompetansemaalCelleFramviser

  def lag_brodsmuler(elementer)
    puts "\n\n\n--------------------------kommer vi hit?"
    if not elementer.empty?
      elementer.map do |element|
        {:klasse => element.class, :tittel => element.tittel, :url => lag_path_for(element, elementer)}
      end
    else
      puts "brodsmuler is empty.."
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
      puts "\n\nempty..."
      ""
    else
      klasser = elementer.map do |e|
        e.class.to_s.downcase
      end
      uuids = elementer.map do |e|
        e.uuid
      end
      puts "\n\n\n\n"
      p klasser
      send(klasser.join("_") + "_path", uuids[0])
    end
  end
end
