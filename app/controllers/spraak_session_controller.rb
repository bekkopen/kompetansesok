class SpraakSessionController < ApplicationController

  def create
    session[:spraak] = params[:spraak][:valg]
    redirect_to root_path
  end
  
end
