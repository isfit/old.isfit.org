class HostsController < ApplicationController


  def new
    @host = Host.new
  end

  def create
    @host = Host.new(params[:host])
    if @host.valid? && @host.save
      #Postoffice.host_add(@host.email).deliver
      redirect_to :action => "done"
    else
      render :new
    end
  end

  def index
    redirect_to :action => :new
		if params[:host]
			@host = Host.new(params[:host])
			if @host.save
				redirect_to :action => "done"
			else
				flash[:warnings] = @host.errors
			end
		end	
  end
	
	def done
		
	end	
end
