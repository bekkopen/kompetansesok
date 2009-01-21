module Kompetansesok
  class KompetansemaalCelleFramviser
    def initialize(kompetansemaal)
      @kompetansemaal = kompetansemaal
    end

    def to_html
      [laereplaner(), hovedomraader(), kompetansemaalsett(), fag()].compact.join("<br/>")
    end

    def laereplaner
      string_joined_on(:laereplaner, @kompetansemaal.t('etiketter.læreplan'))
    end

    def hovedomraader
      string_joined_on(:hovedomraader, @kompetansemaal.t('etiketter.Hovedområde'))
    end

    def kompetansemaalsett
      string_joined_on(:kompetansemaalsett, @kompetansemaal.t('etiketter.kompetansemålsett'))
    end

    def fag
      string_joined_on(:fag, @kompetansemaal.t('etiketter.fag'))
    end

    private    
    def string_joined_on(attribute, tittel, join_string = ", ")
      alle_attr = @kompetansemaal.send(attribute).map do |h|
        h.tittel
      end.join(join_string)
      if alle_attr.empty?
        nil
      else
        "#{tittel}: #{alle_attr}"
      end
    end
  end
end