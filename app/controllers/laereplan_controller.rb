class LaereplanController < ApplicationController

  def show
    @laereplan = Laereplan.find_by_uuid(params[:id])
  end

end
