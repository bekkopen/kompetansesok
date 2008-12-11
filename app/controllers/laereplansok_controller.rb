class LaereplansokController < ApplicationController

  def index
    @kompetansemaal = []
  end

  def create
    @laereplansok = Laereplansok.new(params[:laereplansok])
    @kompetansemaal = @laereplansok.kompetansemaal
    render :action => "index"
  end

end
