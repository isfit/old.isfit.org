require 'bluecloth'

module ArticlesHelper
  def format(str)
    set_correct_tags(str)
    yt_tag(str)
    reg = Regexp.new(/\[([\w ,:"]+)\]\(([A-Za-z0-9_:.=&+-?\/]+)\)/)
    str.gsub!(reg, "<a href=\"\\2\" target=\"_blank\">\\1</a>")

    bc = BlueCloth.new(str) 
    #str.gsub!(/([^>])\s*\r\n\r\n\s*([^<])/m, "\\1<br /><br />\\2")
    #str.gsub!(/([^>])\s*\r\n\s*([^<])/m, "\\1<br />\\2")
    #str

    text = bc.to_html
    #set_correct_tags(text)
    text
  end

  def set_correct_tags(text)
    text.gsub!(/##pic (\d+) (\d+) pic##/) {|match|  article_image($1, $2, false)}
    text.gsub!(/#l#pic (\d+) (\d+) pic#l#/) {|match| article_image($1, $2, true)}
  end

  def yt_tag(text)
    text.gsub!(/##yt (\w+) yt##/, "<iframe width='580' height='302' src='http://www.youtube.com/embed/\\1' showinfo='0' frameborder='0' allowfullscreen></iframe>")
  end

  def article_image(picture_id, type, link)
    picture = Photo.find_by_id(picture_id)
    return "" unless picture
    style = case type
            when "1" then "photo_full"
            when "2" then "photo_right"
            when "3" then "photo_left"
            end

    img_text = Language.to_s == "en" ? picture.image_text_en : picture.image_text_no
    pic_url = type == "1" ? picture.full_article_picture.url : picture.half_article_picture.url
    #Change on prod!
    if (link)
      url = "<a href=/assets/#{picture.original_picture.url}><div class=#{style}><img src =/assets/#{pic_url}  /><br /><i>Foto: #{picture.credits}</i><br /><i>#{picture.image_text_en}</i></div></a>"
    else
      url = "<div class=#{style}><img src =/assets/#{pic_url}  /><br /><i>Foto: #{picture.credits}</i><br /><i>#{picture.image_text_en}</i></div>"
    end 
  end
end
