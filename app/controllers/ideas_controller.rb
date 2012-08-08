class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
  end

  def show
  end

  def create
  end
end
