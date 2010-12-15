class PositionsController < ApplicationController

	def show
		@position = Position.find_by_id(params[:id])
		@sections = Section.find(:all)
		#set_where_am_i(@position)
	end

	def new
		@position = Position.new
	end

	def create
		@position = Position.new(params[:position])
		@position.admission_nr = 5
		save_position
	end

	def edit
		@position = Position.find_by_id(params[:id])
		render(:action => 'new')
	end

	def update
		@position = Position.find_by_id(params[:id])
		@position.attributes = params[:position]
		save_position
	end

	private
	
	def save_position
		if @position.save
			redirect_to(position_path(params[:tab],@position))
		else
			render(:action => 'new')
		end
	end
end



