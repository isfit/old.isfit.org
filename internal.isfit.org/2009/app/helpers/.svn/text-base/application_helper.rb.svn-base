require 'rubygems'
require 'mini_magick'
require 'bluecloth'

module ApplicationHelper
  
  class Helper
      include Singleton
      include ActionView::Helpers::TextHelper
  end
  
	def format(str)
		str_tmp = str.gsub(/\r\n/, "<br />")
		regex = Regexp.new '(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.\~\#\-\%\!\$\&\?\:\;\,\=\+]*(\?\S+)?)?)?)'
    str_tmp.gsub(regex) do |match|
	    '<a href="'+match.to_s+'">'+Helper.instance.truncate(match.to_s,50,"...")+'</a>'
    end
	end
  def format_bc(str)
    bc = BlueCloth.new(str)
	bc.to_html
  end

	def clever_image_tag(source, options = {})
		path = "#{RAILS_ROOT}/public"
		path += "/images/" unless source[0] == '/'
		path += source

		if FileTest.exists?(path)
			if options.include?(:height) or options.include?(:width)
				image = MiniMagick::Image.new(path)
				image_width = image["%w"].to_i
				image_height = image["%h"].to_i

				height = options[:height].to_i if options[:height]
				width = options[:width].to_i if options[:width]

				height = image_height unless height
				width = image_width unless width

				if height and image_height > height
					rel = height.to_f / image_height
					image_height = height
					image_width = rel * image_width
				end
				if width and image_width > width
					rel = width.to_f / image_width
					image_width = width
					image_height = rel * image_height
				end

				height = image_height
				width = image_width
			end

			options[:size] = "#{width}x#{height}"
			image_tag(source, options)
		else
			nil
		end
	end

end
