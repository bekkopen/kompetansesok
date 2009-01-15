class FagController < ApplicationController

  def show
    @fag = Fag.find(params[:id])
  end

end
