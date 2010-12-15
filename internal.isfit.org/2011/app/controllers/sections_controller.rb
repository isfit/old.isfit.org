class SectionsController < ApplicationController

	def show
		@section = Section.find_by_id(params[:id])
	end

	def edit
		@section = Section.find_by_id(params[:id])
		render(:action => 'new')
	end

	def update
		@section = Section.find_by_id(params[:id])
		@section.attributes = params[:section]
		save_section
	end

	private
	def save_section
		if @section.save
			redirect_to(section_path(@section))
		else
			render(:action => 'new')
		end
	end
end
