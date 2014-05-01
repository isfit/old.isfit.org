class WorkshopsPublicController < ApplicationController
  def index
  	@workshops = Workshop.all
  end
end
