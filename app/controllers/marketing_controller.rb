class MarketingController < ApplicationController

  def frontpage
    @articles = Article.frontpage_articles(Language.to_s)

    @stream = Stream.where("(publish_at <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' AND end_at >= '" + Time.now.strftime("%Y-%m-%d %H:%M:%S")+"')").limit(1)[0]

    render layout: "application_no_boxes"
  end

  def world_map
    render layout: "application_clean"
  end
end
