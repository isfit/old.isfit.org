class PositionsController < ApplicationController
  # coding:utf-8
 def index
    @positions = Position.published.includes(:groups).order("groups.section_id, groups.id, positions.title_no")
  end
 
 def show
   @position = Position.find_by_id(params[:id])
   #unless Position.published.all.include?(@position)
   #  redirect_to opptak_path, :notice => "That position does not exist"
   #end
 end

 def section
   @section = Section.find(params[:id])
 end

 def apply
   @applicant = Applicant.new
   @positions = Position.published.includes(:groups).order("groups.section_id, groups.id,positions.title_no")
 end

 def save
    @applicant = Applicant.new(params[:applicant])
    respond_to do |format|
      if @applicant.save
        Postoffice.applicant_add(@applicant.firstname + " " + @applicant.lastname, @applicant.mail).deliver
        flash[:notice] = "Din soknad ble sendt."
        @positions = Position.published
        format.html { render :action => :index }
      else
        flash[:notice] = nil
        @positions = Position.published
        format.html { render :action => :apply }
      end
    end
 end
 def validate
   if params[:field].blank? || params[:value].blank?
     render :nothing => true
   else
     @valid = Applicant.validate_field(params[:field], params[:value])
     render :json => @valid
   end
 end
end
