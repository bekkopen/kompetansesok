class Laereplansok
  attr_accessor :laereplan_tittel, :laereplan_kode
  
  def initialize(params = {})
    self.laereplan_tittel = params[:laereplan_tittel]
    self.laereplan_kode = params[:laereplan_kode]
  end
  

  def kompetansemaal
    Kompetansemaal.find_where(:all, :include => [:kompetansemaalsett,  {:kompetansemaalsett => :laereplaner}] ) do |kompetansemaal, kompetansemaalsett|
      kompetansemaalsett.any do |k|
        k.laereplaner do |l|
          l.tittel =~ parse_text_input(laereplan_tittel)
          l.kode =~ parse_text_input(laereplan_kode)
        end
      end
    end

  end

  private
  def parse_text_input(text)
    if text.blank?
      nil
    else
      "%#{text}%"
    end
  end


end

