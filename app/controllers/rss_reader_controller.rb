class RssReaderController < ApplicationController
  require 'rss/2.0'
  require 'open-uri'
  
  def index
      feed_url = 'http://news.google.no/news?q=global+health&hl=no&client=firefox-a&rls=org.mozilla:nb-NO:official&prmd=lnb&um=1&ie=UTF-8&output=rss'
      output = "<h1>Latest news about global health</h1>" 
      open(feed_url) do |http|
        response = http.read
        result = RSS::Parser.parse(response, false)
        output += "Feed Title: #{result.channel.title}<br />" 
        result.items.each_with_index do |item, i|
          output += "#{i+1}. #{item.title}<br />" if i &lt; 10  
        end  
      end
      render_text output
  end

end