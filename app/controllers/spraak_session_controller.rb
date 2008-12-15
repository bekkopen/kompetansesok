class SpraakSessionController < ApplicationController

  def create
    session[:spraak] = params[:spraak][:valg]
    redirect_to :back
  end
  
end
