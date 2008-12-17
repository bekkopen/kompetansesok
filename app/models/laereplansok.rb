class Laereplansok
  
  @@soekefelter =  [:laereplan_tittel, 
    :laereplan_kode, 
    :hovedomraade, 
    :kompetansemaalsett, 
    :trinn, 
    :kompetansemaal_tittel]

  @@soekefelter.each do |f|
    class_eval do
      attr_accessor f
    end
  end
  
  def initialize(params = {})
    @@soekefelter.each {|soekefelt| self.send("#{soekefelt}=", params[soekefelt]) }
    @page = params[:page]
    @per_page = 10
  end

  def kompetansemaal
    if empty_search?
      Kompetansemaal.paginate :per_page => @per_page, :page => @page
    else
      search_for_kompetansemaal.paginate :per_page => @per_page, :page => @page
    end
  end

  def empty_search?
    empty = true
    @@soekefelter.each do |felt|
      empty = false unless self.send(felt).blank?
    end
    empty
  end

  # genererer en rad med disse kollonene for hvert innslag av kompetansemaal
  # Læreplan  	Hovedområde  	Kompetansemålsett  	Trinn  	Kompetansemålkode  	Kompetansemål
  def to_table_rows
    rows = []
    kompetansemaal.each do |maal|
      # Hovedområder
      maal.hovedomraader.each do |hovedomraade|
        rows << Kompetansesok::KompetansemaalRad.new(:hovedomraade_tittel => hovedomraade.tittel,
                                                     :maal_uuid => maal.uuid,
                                                     :maal_tittel => maal.tittel).as_row
      end
      # Kompetansemålsett
      maal.kompetansemaalsett.each do |kompetansemaalsett|
        unless kompetansemaalsett.trinn.blank?
          # Kompetansemålsett har trinn
          kompetansemaalsett.trinn.each do |trinn|
            unless kompetansemaalsett.laereplaner.blank?
              # Kompetansemålsett har trinn og læreplaner
              kompetansemaalsett.laereplaner.each do |plan|
                rows << Kompetansesok::KompetansemaalRad.new(:laereplan_tittel => plan.tittel,
                                              :kompetansemaalsett_tittel => kompetansemaalsett.tittel,
                                              :trinn_tittel => trinn.tittel,
                                              :maal_uuid => maal.uuid,
                                              :maal_tittel => maal.tittel).as_row
              end
            else
              # Kompetansemålsett har trinn, men ikke læreplaner
              rows << Kompetansesok::KompetansemaalRad.new(:kompetansemaalsett_tittel => kompetansemaalsett.tittel,
                                            :trinn_tittel => trinn.tittel, 
                                            :maal_uuid => maal.uuid,
                                            :maal_tittel => maal.tittel).as_row
            end
          end
        else
          # Kompetansemålsett har ikke trinn
          unless kompetansemaalsett.laereplaner.blank?
            #Kompetansemålsett har læreplaner men ikke trinn
            kompetansemaalsett.laereplaner.each do |plan|
               rows << Kompetansesok::KompetansemaalRad.new(:laereplan_tittel => plan.tittel,
                                              :kompetansemaalsett_tittel => kompetansemaalsett.tittel, 
                                              :maal_uuid => maal.uuid,
                                              :maal_tittel => maal.tittel).as_row
            end
          else
            # Kompetansemålsett har ikke trinn eller læreplaner
            rows << Kompetansesok::KompetansemaalRad.new(:kompetansemaalsett_tittel => kompetansemaalsett.tittel,
                                                         :maal_uuid => maal.uuid,
                                                         :maal_tittel => maal.tittel).as_row
          end
        end
      end

    end
    if rows.empty?
      rows << Kompetansesok::KompetansemaalRad.new.as_row
    else
      rows.uniq.paginate :per_page => @per_page, :page => @page
    end
  end
    

  
  private

  def search_for_kompetansemaal
    joins = [:hovedomraader, :kompetansemaalsett, {:kompetansemaalsett => :laereplaner}, {:kompetansemaalsett => :trinn}]
    Kompetansemaal.find_where(:all, :include => joins) do |kompetansemaal|
      kompetansemaal.all do |maal|
        maal.kompetansemaalsett.all do |sett|
          sett.uuid == kompetansemaalsett
          sett.laereplaner do |plan|
            plan.tittel =~ parse_text_input(laereplan_tittel)
            plan.kode === laereplan_kode.gsub(" ", "").split(';') if laereplan_kode
          end
          sett.trinn do |t|
            t.uuid == trinn
          end
        end
        maal.hovedomraader.all do |h| 
          h.uuid == hovedomraade
        end
        maal.tittel =~ parse_text_input(kompetansemaal_tittel)
      end
    end
  end

  def parse_text_input(text)
    text.blank? ? nil : "%#{text}%"
  end
  
end