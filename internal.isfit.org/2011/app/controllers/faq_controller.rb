class FaqController < ApplicationController
	def index 
		redirect_to :action => "view"
	end

	def view 
		@access = false
		
		if can_access?('faq', 'edit') 
			@access = true
		end
		
		@params = params[:id]
		params[:id] = "main" unless params[:id]
		
		if Faq.exists?(:id => params[:id], :deleted => 0)
			@results = Faq.find(params[:id])
							
		else
			if @access
				redirect_to :action => "edit" , :id => params[:id]
			else
				redirect_to :action => "view", :id => 404
				 
			end
		end
		
		
		
	end
	
		
	def edit
		if request.post?
			if Faq.exists?(params[:id])
				faq = Faq.find(params[:id])
				faq.attributes = params[:faq]	
				faq.deleted = 0
			else
				faq = Faq.new(params[:faq])
				faq.id = params[:id]
			end
			if faq.save
				redirect_to :action => "view"
			else
				@faq = faq
				flash[:warnings] = faq.errors
			end
		else 
			if Faq.exists?(params[:id])

				@faq = Faq.find(params[:id])
			else
				@faq = Faq.new
				@faq.id = params[:id]
			end
		end
		
	end
	
	def method_missing(*info)
		redirect_to :action => "view", :id => info	
	end
	
	def delete
		faq = Faq.find(params[:id])
		faq.deleted = 1
		faq.save
		redirect_to :action => "view"
		
	end
end


