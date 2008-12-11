class Laereplansok
  @@soekefelter = [:laereplan_tittel, :laereplan_kode, :hovedomraade_tittel]

  @@soekefelter.each do |f|
    class_eval do
      attr_accessor f
    end
  end
  
  def initialize(params = {})
    self.laereplan_tittel = params[:laereplan_tittel]
    self.laereplan_kode = params[:laereplan_kode]
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
    Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  :hovedomraader, {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal, kompetansemaalsett, hovedomraader|
      kompetansemaalsett.all do |k|
        k.laereplaner do |l|
          l.tittel =~ parse_text_input(laereplan_tittel)
          l.kode =~ parse_text_input(laereplan_kode)
        end
      end
      hovedomraader.all do |hovedomraade| 
        hovedomraade.tittel =~ parse_text_input(hovedomraade_tittel)
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

