class Laereplansok
  attr_accessor :laereplan_tittel

  def initialize(params)
    @laereplan_tittel = params[:laereplan_tittel]
    @kompetansemaalsett_tittel = params[:kompetansemaalsett_tittel]
  end

  

  def kompetansemaal
    Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal, kompetansemaalsett|
      kompetansemaalsett.any do |k|
        k.laereplaner.any do |l|
          l.tittel =~ parse_text_input(@laereplan_tittel)
        end
      end
    end

  end

  private
  def parse_text_input(text)
    if not text
      nil
    else
      "%#{text}%"
    end
  end


end

