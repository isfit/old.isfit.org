class IsfitOnlinesController < ApplicationController
  def show
    @isfit_online = IsfitOnline.where("(isfit_onlines.start_date <= \"" + Time.now.strftime("%Y-%m-%d %H:%M:%S\""))
                               .where("isfit_onlines.end_date >= \"" + Time.now.strftime("%Y-%m-%d %H:%M:%S\"") + ")")
                               .first

    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
