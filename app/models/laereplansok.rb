class Laereplansok
  @@soekefelter = [:laereplan_tittel, :laereplan_kode, :hovedomraade, :kompetansemaalsett]

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

  private

  def search_for_kompetansemaal
    Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  :hovedomraader, {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal|
      kompetansemaal.all do |maal|
        maal.kompetansemaalsett.all do |sett|
          sett.uuid == kompetansemaalsett
          sett.laereplaner do |plan|
            plan.tittel =~ parse_text_input(laereplan_tittel)
            plan.kode =~ parse_text_input(laereplan_kode)
          end
        end
        maal.hovedomraader.all do |h| 
          h.uuid == hovedomraade
        end
      end
    end
  end

  def parse_text_input(text)
    if text.blank?
      nil
    else
      "%#{text}%"
    end
  end


end

