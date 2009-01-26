module Kompetansesok
  module KompetansemaalCelleFramviser
    
    def sorted_rows(kompetansemaal, sort_on = :tittel, max_treshold = 30)
      unsorted = generate_unsorted_rows(kompetansemaal, max_treshold) 
      sort_rows(unsorted, sort_on)
    end

    
    private    
    
    def to_detail_html(kompetansemaal)
      [kompetansemaal.tittel.capitalize, laereplaner(kompetansemaal), hovedomraader(kompetansemaal), kompetansemaalsett(kompetansemaal), fag(kompetansemaal)].compact.join("<br/>")
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
    
   
    def string_joined_on(kompetansemaal, attribute, tittel, join_string = ", ")
      alle_attr = kompetansemaal.send(attribute).map do |h|
        h.tittel
      end.join(join_string)
      if alle_attr.empty?
        nil
      else
        "<span class='kompetansemaal_detaljer'><span class='kompetansemaal_detaljer_#{attribute}'>#{alle_attr}</span></span>"
      end
    end
    
    def generate_unsorted_rows(kompetansemaal, max_treshold)
      if kompetansemaal.length < max_treshold
        kompetansemaal.map do |maal|
          possible_sort_by = {:laereplan => laereplaner(maal), 
            :hovedomraade => hovedomraader(maal), 
            :kompetansemaalsett => kompetansemaalsett(maal),
            :fag => fag(maal) }
          [maal.uuid, maal.kode, maal.tittel, to_detail_html(maal), possible_sort_by]
        end
      else
        kompetansemaal.map do |maal|
          [maal.uuid, maal.kode, maal.tittel, maal.tittel.capitalize, {}]
        end
      end
    end
    
    def sort_rows(rows, sort_on)
      sort_last = 'åååååå'
      rows.sort_by do |row|
        if sort_on == :tittel
          row[2]
        else
          [row.last[sort_on] || sort_last, row[2] || sort_last]
        end
      end
    end
    
  end
end