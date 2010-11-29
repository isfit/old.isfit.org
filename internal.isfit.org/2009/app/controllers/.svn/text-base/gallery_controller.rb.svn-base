class GalleryController < ApplicationController

  def index
	@path = "#{RAILS_ROOT}/public/images/gallery"
  end

  # This action is used to show the images in an album
  def album
	path = "#{RAILS_ROOT}/public/images/gallery"
	# Post data
    album 	= params[:album] 

	# Some paramteres
	@album_name = album[:album_name]
	@folder = "#{path}/#{@album_name}"
	@current_image_pos = album[:selected].to_i


	# Album utility
    @album = Album.new()

	# Collect all image files
	files = Dir["#{@folder}*/*.{jpg,png}"].sort
	@total_images = files.size	
    @current_image = files[@current_image_pos ]

    # Get all thumbs we want to show. (2 ahead and 2 behind?)   
    @thumbs = [nil,nil,nil,nil,nil]
	@size = files.size
	behind_cnt = 2
    ahead_cnt = 2 

	# Thumbs behind
    if(@current_image_pos - behind_cnt >= 0) 
      @thumbs[0] = @album.get_thumb(files[@current_image_pos-2], @folder, @album_name)
	  @thumbs[1] = @album.get_thumb(files[@current_image_pos-1], @folder, @album_name)
	elsif(@current_image_pos - behind_cnt == -1)
	  @thumbs[1] = @album.get_thumb(files[@current_image_pos-1], @folder, @album_name)
	end

	@thumbs[2] = @album.get_thumb(files[@current_image_pos], @folder, @album_name) 

	# Thumbs ahead
    if(files.size - @current_image_pos > 2) 
      @thumbs[3] = @album.get_thumb(files[@current_image_pos+1], @folder, @album_name)
	  @thumbs[4] = @album.get_thumb(files[@current_image_pos+2], @folder, @album_name)
	elsif(files.size - @current_image_pos == 2)
	  @thumbs[3] = @album.get_thumb(files[@current_image_pos+1], @folder, @album_name)
	end



	# Find all comments asociated with image
	@comments = GalleryComment.find(:all,:conditions=>"image like '#{@current_image}'")
  end

  def comment
    if request.post?
	  album   = params[:album]
      comment = GalleryComment.new
	  comment.isfit_user = current_user.id
	  comment.text = album[:comment]
      comment.image = album[:current_image]
	  comment.save
	  redirect_to :action => "album", :album => album
    end    

  end

end
