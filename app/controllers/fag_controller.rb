class FagController < ApplicationController

  def show
    @fag = Fag.find_by_uuid(params[:id])
  end

end
