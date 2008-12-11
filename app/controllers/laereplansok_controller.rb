class LaereplansokController < ApplicationController

  def index
    @kompetansemaal = []
  end

  def create
    @laereplansok = Laereplansok.new :laereplan_tittel => params[:laereplansok][:laereplan_tittel]
    @kompetansemaal = @laereplansok.kompetansemaal
    render :action => "index"
  end

end
