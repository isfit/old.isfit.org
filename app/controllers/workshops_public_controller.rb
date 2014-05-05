class WorkshopsPublicController < ApplicationController
  def index
  	@workshops = Workshop.order("rank ASC").all
  end

  def show
  	@workshop = Workshop.find_by_id(params[:id])
  end
end
