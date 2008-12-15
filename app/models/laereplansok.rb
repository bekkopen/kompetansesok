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
      maal.kompetansemaalsett.each do |kompetansemaalsett|
        unless maal.hovedomraader.blank?
          maal.hovedomraader.each do |hovedomraade|
            unless kompetansemaalsett.trinn.empty?
              kompetansemaalsett.trinn.each do |trinn|
                laereplan =""
                laereplan = kompetansemaalsett.laereplan.tittel unless kompetansemaalsett.laereplan == nil
                rows << [kompetansemaalsett.laereplan.tittel, hovedomraade.tittel, kompetansemaalsett.tittel, trinn.tittel, "", maal.tittel]
              end
            else
              rows << [kompetansemaalsett.laereplan.tittel, hovedomraade.tittel, kompetansemaalsett.tittel, "", "", maal.tittel]
            end
          end
        else
          unless kompetansemaalsett.trinn.empty?
              kompetansemaalsett.trinn.each do |trinn|
                laereplan = ""
                laereplan = kompetansemaalsett.laereplan.tittel unless kompetansemaalsett.laereplan == nil
                rows << [kompetansemaalsett.laereplan.tittel, "", kompetansemaalsett.tittel, trinn.tittel, "", maal.tittel]
              end
            else
              rows << [kompetansemaalsett.laereplan.tittel, "", kompetansemaalsett.tittel, "", "", maal.tittel]
            end
        end
        
      end
    end
    
    rows.paginate :per_page => @per_page, :page => @page
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
            plan.kode =~ parse_text_input(laereplan_kode)
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