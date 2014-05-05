class WorkshopsPublicController < ApplicationController
  def index
  	@workshops = Workshop.order("rank ASC").all
  end
end
