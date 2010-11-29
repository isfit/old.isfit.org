class SweaterOrderController < ApplicationController
	helper :sort
	include SortHelper
	
	def index
		if params[:id]
			@id = params[:id]
			if @id.to_i == 1
				session[:sweater_clause] = "not abort"
			else
				session[:sweater_clause] = "1"
			end
		end
		sort_init 'sweater_orders.id'
		sort_update
		@orders = SweaterOrder.paginate(:page => params[:page], 
			:order => sort_clause,
			:conditions => session[:sweater_clause])
	end
	
	def abort
		if params[:id] != ""
			so = SweaterOrder.find(params[:id])
			so.abort = true
			so.save
		end
		redirect_to :action => :index
	end
end
