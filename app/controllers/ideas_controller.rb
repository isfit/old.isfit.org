class IdeasController < ApplicationController
  def index
    puts 'hello world!'
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

  def update
    respond_to :json
    require 'open-uri'
    require 'json'

    puts '------------------------'
    @idea = Idea.find(params[:id])
    url = "https://api.facebook.com/method/fql.query?query=select%20like_count%20from%20link_stat%20where%20url='http://beta.isfit.org/ideas/"+params[:id]+"'&format=json"

    result = JSON.parse(open(url).read)[0]['like_count']

    #@idea.like_count = result
    #@idea.save

    puts result

  end
end
