class HostsController < ApplicationController


  def new
    @host = Host.new
  end

  def create
    @host = Host.new(params[:host])
    if @host.valid? && verify_recaptcha(:model=>@host, :message=>"Recaptcha verification failed") && @host.save
      redirect_to :action => "done", :tab => params[:tab]
    else
      verify_recaptcha(:model=>@host, :message=>"Recaptcha verification failed")
      render :new
    end
  end

#	def index
#		if params[:host]
#			@host = Host.new(params[:host])
#			if @host.save
#				redirect_to :action => "done"
#			else
#				flash[:warnings] = @host.errors
#			end
#		end	
#	end
	
	def done
		
	end	
end
