class BlogsController < ApplicationController
  require 'rss/2.0'
  require 'open-uri'

  respond_to :json

  def festival
    @posts = []
    
    if Language.to_s == 'no'
      festival_url = 'http://isfit2013.blogspot.com/feeds/posts/default?alt=rss'
    else
      festival_url = 'http://isfit2013eng.blogspot.com/feeds/posts/default?alt=rss'
    end

    open(festival_url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false)

      result.items.each_with_index do |item, i|
        @posts.push({
          'title' => item.title,
          'description' => item.description,
          'author' => item.author,
          'link' => item.link, 
          'pubDate' => item.pubDate
          })
      end  
    end

    respond_with([@posts[0]])
  end

  def theme
    # TODO
  end

end