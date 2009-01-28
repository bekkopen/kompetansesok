class InfoController < ApplicationController
  def index
  end
  
  def show
  end
  
  def statistikk
    @statistikk = Info.sok_statistikk
  end
end
