class MarketingController < ApplicationController

  def frontpage
    @articles = Article.where("(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL)").where(deleted: 0).where(list: 1).order("weight DESC").limit(3)
    if Language.to_s =="en"
      @articles.reject!{|x| x.title_en == "" }
    else
      @articles.reject!{|x| x.title_no == "" }
    end

    @stream = Stream.where("(publish_at <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' AND end_at >= '" + Time.now.strftime("%Y-%m-%d %H:%M:%S")+"')").limit(1)[0]

    render layout: "application_no_boxes"
  end

  def world_map
    render layout: "application_clean"
  end
end
