class PhotosController < ApplicationController


  def show
    id = params[:id]
    imgurUrl = 'http://api.imgur.com/2/album/'

    @images = JSON.parse(open(imgurUrl+ id +'.json').read)['album']['images']
  end
  def index
  
  end


end
