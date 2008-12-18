class Laereplansok
  
  @@soekefelter =  [:laereplan_tittel, 
    :laereplan_kode, 
    :hovedomraade_uuid,
    :hovedomraade_kode,
    :kompetansemaalsett_uuid,
    :trinn_uuid,
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

  def laereplaner
    Laereplan.find_where(:all) do |laereplan|
      laereplan.all do |l|
        l.tittel =~ make_ready_for_like(laereplan_tittel)
      end
      laereplan.any do |l|
        search_for_any(l, laereplan_kode)
      end
    end
  end

  def kompetansemaalsett
    laereplaner.map do |plan|
      plan.kompetansemaalsett
    end.flatten.uniq
  end

  def kompetansemaal
    if empty_search?
      Kompetansemaal.find(:all)
    else
      search_for_kompetansemaal
    end
  end

  def empty_search?
    empty = true
    @@soekefelter.each do |felt|
      empty = false unless self.send(felt).blank?
    end
    empty
  end

  #mange-til-mange relasjonene gjør at kan få flere rader per kompetansemål
  def to_table_rows
    rows = []
    kompetansemaal.each do |maal|
      maal_verdier = {:maal_uuid => maal.uuid, :maal_kode => maal.kode, :maal_tittel => maal.tittel}
      # Hovedområder
      maal.hovedomraader.each do |hovedomraade|
        rad_verdier = maal_verdier.merge(:hovedomraade_tittel => hovedomraade.tittel)
        rows << Kompetansesok::KompetansemaalRad.new(rad_verdier).as_row
      end
      # Kompetansemålsett
      maal.kompetansemaalsett.each do |kompetansemaalsett|
        unless kompetansemaalsett.trinn.blank?
          # Kompetansemålsett har trinn
          kompetansemaalsett.trinn.each do |trinn|
            unless kompetansemaalsett.laereplaner.blank?
              # Kompetansemålsett har trinn og læreplaner
              kompetansemaalsett.laereplaner.each do |plan|
                rad_verdier = maal_verdier.merge(:laereplan_tittel => plan.tittel,
                                                 :kompetansemaalsett_tittel => kompetansemaalsett.tittel,
                                                 :trinn_tittel => trinn.tittel)
                rows << Kompetansesok::KompetansemaalRad.new(rad_verdier).as_row
              end
            else
              # Kompetansemålsett har trinn, men ikke læreplaner
              rad_verdier = maal_verdier.merge(:kompetansemaalsett_tittel => kompetansemaalsett.tittel,
                                               :trinn_tittel => trinn.tittel)
              rows << Kompetansesok::KompetansemaalRad.new(rad_verdier).as_row
            end
          end
        else
          # Kompetansemålsett har ikke trinn
          unless kompetansemaalsett.laereplaner.blank?
            #Kompetansemålsett har læreplaner men ikke trinn
            kompetansemaalsett.laereplaner.each do |plan|
               rad_verdier = maal_verdier.merge(:laereplan_tittel => plan.tittel,
                                                :kompetansemaalsett_tittel => kompetansemaalsett.tittel)
               rows << Kompetansesok::KompetansemaalRad.new(rad_verdier).as_row
            end
          else
            # Kompetansemålsett har ikke trinn eller læreplaner
            rad_verdier = maal_verdier.merge(:kompetansemaalsett_tittel => kompetansemaalsett.tittel)
            rows << Kompetansesok::KompetansemaalRad.new(rad_verdier).as_row
          end
        end
      end

    end
    if rows.empty?
      rows
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
          sett.uuid == kompetansemaalsett_uuid
          sett.laereplaner do |plan|
            plan.tittel =~ make_ready_for_like(laereplan_tittel)
          end
          sett.laereplaner.any do |plan|
            search_for_any(plan, laereplan_kode)
          end
          sett.trinn do |t|
            t.uuid == trinn_uuid
          end
        end
        maal.hovedomraader.all do |h| 
          h.uuid == hovedomraade_uuid
        end
        maal.hovedomraader.any do |h|
          search_for_any(h, hovedomraade_kode)
        end
        maal.tittel =~ make_ready_for_like(kompetansemaal_tittel)
      end
    end
  end

  def search_for_any(item, codes )
   split_string_on_semicolon(codes).each do |sokt_kode|
     item.kode =~ make_ready_for_like(sokt_kode)
   end
  end

  def make_ready_for_like(text)
    if text.blank? 
      nil
    else
      text_with_wildcards = use_star_as_wildcard(text)
      percent_at_start_and_end(text_with_wildcards)
    end
  end
  
  def split_string_on_semicolon(string)
    string.nil? ? [] : string.gsub(" ", "").split(';')
  end
  
  def use_star_as_wildcard(text)
    text.gsub('*', '%')
  end
  
  def percent_at_start_and_end(text)
    "%#{text}%"
  end
  
end