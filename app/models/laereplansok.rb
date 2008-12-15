class Laereplansok
  @@soekefelter = [:laereplan_tittel, :laereplan_kode, :hovedomraade]

  @@soekefelter.each do |f|
    class_eval do
      attr_accessor f
    end
  end
  
  def initialize(params = {})
    self.laereplan_tittel = params[:laereplan_tittel]
    self.laereplan_kode = params[:laereplan_kode]
    self.hovedomraade = params[:hovedomraade]
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
                laereplan =""
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
    #    k = Kompetansemaal.find_where(:all, :include => [:hovedomraader] ) do |kompetansemaal|
    k = Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  :hovedomraader, {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal|
      kompetansemaal.all do |maal|
        maal.kompetansemaalsett.all do |sett|
          sett.laereplaner do |plan|
            plan.tittel =~ parse_text_input(laereplan_tittel)
            plan.kode =~ parse_text_input(laereplan_kode)
          end
        end
        maal.hovedomraader.all do |h|
          h.uuid =~ parse_text_input(hovedomraade)
        end
      end
    end
    
    #    k.each do |m|
    #      puts m.hovedomraader.first.uuid
    #    end
    
    k
  end

  def parse_text_input(text)
    if text.blank?
      nil
    else
      "%#{text}%"
    end
  end


end

