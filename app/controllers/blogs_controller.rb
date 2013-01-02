class BlogsController < ApplicationController
  require 'rss'
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
    @posts = []
    
    url = 'http://isfit.github.com/blog/atom.xml'

    open(url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false, false)

      result.entries.each do |item|
        puts item.title.content
        if Language.to_s == item.link.lang
          @posts.push({
            'title' => item.title.content,
            'description' => item.content.content,
            'link' => item.id.content, 
            'pubDate' => item.updated.content
          })
        end
      end  
    end

    respond_with(@posts)

  end

end