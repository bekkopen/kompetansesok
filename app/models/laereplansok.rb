class Laereplansok
  @@soekefelter = [:laereplan_tittel, :laereplan_kode]

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
    if isEmptySearch
      Kompetansemaal.paginate :per_page => @per_page, :page => @page
    else
      searchForKompetansemaal.paginate :per_page => @per_page, :page => @page
    end
  end

  def isEmptySearch
    empty = true
    @@soekefelter.each do |felt|
      empty = false unless self.send(felt).blank?
    end
    empty
  end

  private

  def searchForKompetansemaal
    Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal, kompetansemaalsett|
      kompetansemaalsett.any do |k|
        k.laereplaner do |l|
          l.tittel =~ parse_text_input(laereplan_tittel)
          l.kode =~ parse_text_input(laereplan_kode)
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

