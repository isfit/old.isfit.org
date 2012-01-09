class PositionsController < ApplicationController
  # coding:utf-8
 def index
    @positions = Position.published
  end
 
 def show
   @position = Position.find_by_id(params[:id])
   #unless Position.published.all.include?(@position)
   #  redirect_to opptak_path, :notice => "That position does not exist"
   #end
 end

 def apply
   @applicant = Applicant.new
   @positions = Position.published.order(:title_en).reverse
   @positions << Position.new
 end

 def save
    @applicant = Applicant.new(params[:applicant])
    respond_to do |format|
      if @applicant.save
        flash[:notice] = "Din soknad ble sendt."
        @positions = Position.published
        format.html { render :action => :index }
      else
        flash[:notice] = nil
        @positions = Position.published
        @positions << Position.new
        @positions.reverse    
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
