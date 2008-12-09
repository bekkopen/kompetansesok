class HovedomraaderController < ApplicationController
  # GET /hovedomraader
  def index
    @hovedomraader = Hovedomraade.find(:all)
  end

  # GET /hovedomraader/1
  def show
    @hovedomraade = Hovedomraade.find(params[:id])
  end
  
end
