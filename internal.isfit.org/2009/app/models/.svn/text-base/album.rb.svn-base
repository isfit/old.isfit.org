class Album
require 'ftools'

  def create_all_thumbs(folder)
	files = Dir["#{folder}*/*"]
    #Dir.mkdir("#{folder}/thumbs")
	
	files.each do |f|
      begin
	    self.create_thumb(f,folder)
      rescue
        # error handling needed..?
      end
	end
  end

  def create_thumb(file, folder)
	max_size = 100

	# Copy image
	name = file[folder.size+1,file.size]
	new_file = "#{folder}/thumbs/#{name}"

    File.copy(file, new_file)

	# Resize the image
    image = MiniMagick::Image.new(new_file)
    w = image["%w"]
    h = image["%h"]

    w = w.to_f
    h = h.to_f
    if (w > max_size || h > max_size)
      if (w > h)
        image.resize "#{max_size}X"
      else
        image.resize "X#{max_size}"
      end
    end
  end
  
  def image_info(image_path, folder_path, album_name)
	image = {}
    image[:name] = image_path[folder_path.size+1,image_path.size]
    image[:url] = "gallery/#{album_name}/#{image[:name]}"
    image
  end

  def get_thumb(image_path, folder_path, album_name)

    image = {}
    image[:name] = image_path[folder_path.size+1,image_path.size]

	unless FileTest.exists?("#{folder_path}/thumbs")
        Dir.mkdir("#{folder_path}/thumbs")
    end
	unless FileTest.exists?("#{folder_path}/thumbs/#{image[:name]}")
      self.create_thumb(image_path, folder_path)
	end

    "gallery/#{album_name}/thumbs/#{image[:name]}"
  end
	

end
