class MarketingController < ApplicationController
  def frontpage
    @articles = Article.where("(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL)").where(deleted: 0).where(list: 1).order("weight DESC").limit(5)
    if Language.to_s =="en"
      @articles.reject!{|x| x.title_en == "" }
    else
      @articles.reject!{|x| x.title_no == "" }
    end

    render layout: "application_no_boxes"
  end
end
