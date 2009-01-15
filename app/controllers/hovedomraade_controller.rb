class HovedomraadeController < ApplicationController

  def show
    @hovedomraade = Hovedomraade.find_by_uuid(params[:id])
  end

end
