module Kompetansesok
  module KompetansemaalCelleFramviser
    
    def sorted_rows(kompetansemaal, skip_details_for = [], max_treshold = 30)
      unsorted = generate_unsorted_rows(kompetansemaal, plural_classnames_as_symbols(skip_details_for), max_treshold) 
      sort_rows(unsorted)
    end

    
    private    
    
    def to_detail_html(kompetansemaal, skip_details_for = [])
      ["<h3>#{kompetansemaal.tittel.capitalize}</h3>", 
        skip_details_for.include?(:laereplaner) ? nil : laereplaner(kompetansemaal), 
        skip_details_for.include?(:hovedomraader) ? nil : hovedomraader(kompetansemaal), 
        skip_details_for.include?(:kompetansemaalsett) ? nil : kompetansemaalsett(kompetansemaal), 
        skip_details_for.include?(:fag) ? nil : fag(kompetansemaal)
      ].compact.join("<br/>")
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
      attributter = kompetansemaal.send(attribute).map do |h|
        {
          :ikon_tekst => h.ikon_tekst,
          :tittel => h.tittel,
          :class => h.class
        }
      end
      if attributter.empty?
        nil
      else
        # Vi må bruke enkeltfnutter for å unngå at nokogiri klager
        ikon_span = %{<span class='ikon ikon_#{attributter[0][:class]}'>#{attributter[0][:ikon_tekst]}</span>}
        titler = attributter.map{|a| a[:tittel]}.join(join_string)
        %{<div class='kompetansemaal_detaljer'>#{ikon_span} #{titler}</div>}
      end
    end
    
    def generate_unsorted_rows(kompetansemaal, skip_details_for = [], max_treshold = 30)
      if kompetansemaal.length < max_treshold
        kompetansemaal.map do |maal|
          possible_sort_by = {:laereplan => laereplaner(maal), 
            :hovedomraade => hovedomraader(maal), 
            :kompetansemaalsett => kompetansemaalsett(maal),
            :fag => fag(maal),
            :kompetansemaal => maal.tittel }
          [maal.uuid, maal.kode, maal.tittel, to_detail_html(maal, skip_details_for), possible_sort_by]
        end
      else
        kompetansemaal.map do |maal|
          possible_sort_by = {:kompetansemaal => maal.tittel}
          [maal.uuid, maal.kode, maal.tittel, maal.tittel.capitalize, possible_sort_by]
        end
      end
    end
    
    def sort_rows(rows)
      sort_last = 'åååååå'
      rows.sort_by do |row|
        [row.last[:laereplan] || sort_last,
          row.last[:hovedomraade] || sort_last,
          row.last[:kompetansemaalsett] || sort_last,
          row.last[:fag] || sort_last,
          row.last[:kompetansemaal] || sort_last ]
      end
    end
    
    def plural_classnames_as_symbols(klasses)
      klasses.map do |klass|
        klass.class.to_s.downcase.pluralize.to_sym
      end
    end
    
  end
end