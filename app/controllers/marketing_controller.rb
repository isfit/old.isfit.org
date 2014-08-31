#encoding: utf-8
class MarketingController < ApplicationController

  def frontpage
    @articles = Article.frontpage_articles(Language.to_s)

    @stream = Stream.where("(publish_at <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' AND end_at >= '" + Time.now.strftime("%Y-%m-%d %H:%M:%S")+"')").limit(1)[0]

    flash[:notice] = world_tour_notice
    render layout: "application_no_boxes"
  end

  def world_map
    render layout: "application_clean"
  end

  private
  def world_tour_notice
    if Language.to_s.eql?("en")
      if Time.now < Time.parse("2014-09-01 04:00")
        "<p style='text-align: center'>Want to be a volunteer in Trondheim? " +
        "Visit <a href=\"https://opptak.isfit.org/?locale=en\">" +
        "opptak.isfit.org</a>.</p>"
      else
      "<p style='text-align: center'>ISFiT is now on a World Tour. " +
      "Read more about it on the <a href=\"http://isfit-ambassadors.blogspot.no\">" +
      "ISFiT Ambassador blog</a>.</p>"
      end
    else
      "<p style='text-align: center'>ISFiT er på verdensturné. " +
      "Les mer på <a href=\"http://isfit-ambassadors.blogspot.no\">" +
      "ISFiT Ambassadør-bloggen</a>.</p>"
    end
  end
end
