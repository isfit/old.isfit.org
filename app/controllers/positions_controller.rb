class PositionsController < ApplicationController
 def index
   @positions = []
  # return
   # QUICKFIX, REMOVE THE ABOVE IN NOVEMBER; AND FIX POSITIONS IN CORE!!
  @positions = Position.find_all_active_positions
  end
 
 def show
   @position = Position.find_by_id(params[:id])
 end

 def apply
   @applicant = Applicant.new
   @positions = Position.find_all_active_positions_alfa.reverse
   @positions << Position.new
 end
 def save
    @applicant = Applicant.new(params[:applicant])
    respond_to do |format|
      if @applicant.save
        flash[:notice] = "Din soknad ble sendt."
        @positions = Position.find_all_active_positions
        format.html { render :action => :index }
      else
        flash[:notice] = nil
        @positions = Position.find_all_active_positions_alfa
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
