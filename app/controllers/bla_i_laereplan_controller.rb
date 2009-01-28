class BlaILaereplanController < ApplicationController
  def index
    @laereplaner = Laereplan.find :all
    @laereplaner = @laereplaner.sort_by do |l|
      if params[:sort] == "kode"
        l.kode.downcase
      else
        l.tittel.downcase
      end
    end
  end
end
