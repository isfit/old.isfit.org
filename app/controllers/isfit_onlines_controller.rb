class IsfitOnlinesController < ApplicationController
  def show
    @isfit_online = IsfitOnline.first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @isfit_online }
    end
  end
end
