class ProxiesController < ApplicationController
  class rss

  end

  class instagram
     respond_to do |format|

      format.json { render :json => ''}
    end
  end
end