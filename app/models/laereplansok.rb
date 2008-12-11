class Laereplansok
  attr_accessor :laereplan_tittel

  

  def initialize(params)
    @laereplan_tittel = params[:laereplan_tittel]
    @kompetansemaalsett_tittel = params[:kompetansemaalsett_tittel]
    @page = params[:page]
    @per_page = 10
  end

  def kompetansemaal
    if @laereplan_tittel == nil || @laereplan_tittel.length == 0
      Kompetansemaal.paginate :per_page => @per_page, :page => @page
    else
      searchForKompetansemaal.paginate :per_page => @per_page, :page => @page
    end
  end

  private

  def searchForKompetansemaal
    Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal, kompetansemaalsett|
      kompetansemaalsett.any do |k|
        k.laereplaner.any do |l|
          l.tittel =~ parse_text_input(@laereplan_tittel)
        end
      end
    end
  end

  def parse_text_input(text)
    if not text
      nil
    else
      "%#{text}%"
    end
  end


end

