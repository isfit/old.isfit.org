class IdeasController < ApplicationController
  def index
    puts 'hello world!'
    @idea  = Idea.new
    @ideas = Idea.order("like_count DESC").limit(5)
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    if OauthUser.find_by_token(params[:idea][:email])
      user = OauthUser.find_by_token(params[:idea][:email])
      @idea = Idea.new(params[:idea])
      @idea.submitted_by_name = user.name
      @idea.submitted_by_id = user.facebook_id
      if @idea.save
        redirect_to @idea, :notice => 'Idea submitted. Share this link to all your friends!'
      else
        redirect_to ideas_path, :notice => 'We are terribly sorry, but we seem to have failed to save your idea. Try again later.'
      end
    else
      redirect_to ideas_path, :notice => 'We are terribly sorry, but we seem have failed to authorize you properly. Try again later.'
    end

  end

  def update
    require 'open-uri'
    require 'json'

    puts '------------------------'
    @idea = Idea.find(params[:id])
    url = "https://api.facebook.com/method/fql.query?query=select%20share_count,like_count,comment_count,total_count%20from%20link_stat%20where%20url='http://beta.isfit.org/ideas/"+ params[:id] +"'&format=json"

    result = JSON.parse(open(url).read)[0]['total_count']
    puts '------------------------'
    puts result
    puts '------------------------'

    @idea.like_count = result
    @idea.save

    @lol = @idea.like_count

  end
end
