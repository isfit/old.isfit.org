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
    while text.index('##pic') != nil
      t_start = text.index('##pic')
      t_end = text.index('pic##')
      reg = Regexp.new(/##pic (\d+) (\d+) pic##/)
        match = reg.match(text[t_start..t_end+4])
      #img_id = text[t_start+6].chr
      #img_type = text[t_start+8].chr
      img_id = match[1]
      img_type = match[2]
      url = article_image(img_id.to_i, img_type.to_i, false)
      text[t_start..t_end+4] = url
    end
    #text.gsub!(/##pic (\d+) (\d+) pic##/, article_image("\\1".to_i, "\\2".to_i, false))

    #text.gsub!(/#l#pic (\d+) (\d+) pic#l#/, article_image("\\1".to_i, "\\2".to_i, true))
          while text.index('#l#pic') != nil
            t_start = text.index('#l#pic')
            t_end = text.index('pic#l#')
            reg = Regexp.new(/#l#pic (\d+) (\d+) pic#l#/)
            match = reg.match(text[t_start..t_end+5])
            #img_id = text[t_start+6].chr
            #img_type = text[t_start+8].chr
            img_id = match[1]
            img_type = match[2]
            url = article_image(img_id.to_i, img_type.to_i, true)
            text[t_start..t_end+5] = url
          end 
  end

  def yt_tag(text)
    text.gsub!(/##yt (\w+) yt##/, "<iframe width='530' height='302' src='http://www.youtube.com/embed/\\1' frameborder='0' allowfullscreen></iframe>")

      #    while text.index('##yt') != nil
      #      t_start = text.index('##yt')
      #      t_end = text.index('yt##')
      #      reg = Regexp.new(/##yt (\w+) yt##/)
      #      match = reg.match(text[t_start..t_end+3])
      #      yt_id = match[1]
      #      url = "<iframe width='530' height='302' src='http://www.youtube.com/embed/#{yt_id}' frameborder='0' allowfullscreen></iframe>"
      #      text[t_start..t_end+3] = url
      #    end
  end

  def article_image(picture_id, type, link)
    picture = Photo.find_by_id(picture_id)
    return "" unless picture
    style = case type.to_s
            when "1" then "photo_full"
            when "2" then "photo_right"
            when "3" then "photo_left"
            end

    img_text = Language.to_s == "en" ? picture.image_text_en : picture.image_text_no
    pic_url = type == 1 ? picture.full_article_picture.url : picture.half_article_picture.url
    #Change on prod!
    if (link)
      url = "<a href=/assets/#{picture.original_picture.url}><div class=#{style}><img src =/assets/#{pic_url}  /><br /><i>Foto: #{picture.credits}</i><br /><i>#{picture.image_text_en}</i></div></a>"
    else
      url = "<div class=#{style}><img src =/assets/#{pic_url}  /><br /><i>Foto: #{picture.credits}</i><br /><i>#{picture.image_text_en}</i></div>"
    end 
  end
end
