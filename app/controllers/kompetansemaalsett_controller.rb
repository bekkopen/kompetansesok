class KompetansemaalsettController < ApplicationController

  def show
    @kompetansemaalsett = Kompetansemaalsett.find_by_uuid(params[:id])
    @kompetansemaal_treff = @kompetansemaalsett.kompetansemaal.map{|t| [t.uuid, t.kode, t.tittel] }
  end

end