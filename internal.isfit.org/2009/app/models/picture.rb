class Picture
  attr_accessor :id, :file
     
  def initialize(path,file,max_size)
    @file = file
    @content_type = file.content_type.chomp 
	@path = path
	@max_size = max_size 
  end
     
  def save
    if @file
      if @content_type =~ /^image/
        #Then create the file
        f = File.new(@path,"wb")
        f.write file.read
        f.close

		# Resize the image
		resize(@path)
      end
    end
  end
  
  def resize(path)
    image = MiniMagick::Image.new(path)
    w = image["%w"]
	h = image["%h"]

    w = w.to_f
    h = h.to_f
    if (w > @max_size || h > @max_size)
      if (w > h)
		image.resize "#{@max_size}X"
      else
		image.resize "X#{@max_size}"
      end
    end
  end  
end 
