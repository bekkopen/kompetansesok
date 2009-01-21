module Kompetansesok
  module KompetansemaalCelleFramviser
    def to_detalje_html(kompetansemaal)
      [laereplaner(kompetansemaal), hovedomraader(kompetansemaal), kompetansemaalsett(kompetansemaal), fag(kompetansemaal)].compact.join("<br/>")
    end

    def laereplaner(kompetansemaal)
      string_joined_on(kompetansemaal, :laereplaner, t('etiketter.læreplan'))
    end

    def hovedomraader(kompetansemaal)
      string_joined_on(kompetansemaal,:hovedomraader, t('etiketter.hovedområde'))
    end

    def kompetansemaalsett(kompetansemaal)
      string_joined_on(kompetansemaal,:kompetansemaalsett, t('etiketter.kompetansemålsett'))
    end

    def fag(kompetansemaal)
      string_joined_on(kompetansemaal,:fag, t('etiketter.fag'))
    end

    private    
    def string_joined_on(kompetansemaal, attribute, tittel, join_string = ", ")
      alle_attr = kompetansemaal.send(attribute).map do |h|
        h.tittel
      end.join(join_string)
      if alle_attr.empty?
        nil
      else
        "<span class='kompetansemaal_detaljer'>#{tittel}: #{alle_attr}</span>"
      end
    end
  end
end