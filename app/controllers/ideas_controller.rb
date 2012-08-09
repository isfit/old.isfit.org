class IdeasController < ApplicationController
  def index
    @idea  = Idea.new
    @ideas = Idea.all(:order => "created_at DESC")
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    @idea = Idea.new(params[:idea])
    if @idea.save
      redirect_to ideas_path, :notice => 'Huge success!'
    else
      redirect_to ideas_path, :notice => 'Major defeat!'
    end

  end
end
