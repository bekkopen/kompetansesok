class KompetansemaalsettController < ApplicationController
  # GET /kompetansemaalsett
  # GET /kompetansemaalsett.xml
  def index
    @kompetansemaalsett = Kompetansemaalsett.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kompetansemaalsett }
    end
  end

end
