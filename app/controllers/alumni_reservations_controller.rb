class AlumniReservationsController < ApplicationController
  respond_to :html
  def new
    unless true
    @alumni_reservation = AlumniReservation.new

    @peaceprize_ceremony_count=AlumniReservation.where(:peaceprize_ceremony =>1).count
    @hybel_friday_count= AlumniReservation.where(:hybel_friday =>1).count
    @restaurant_count=AlumniReservation.where(:restaurant =>1).count
    @hybel_saturday_count=AlumniReservation.where(:hybel_saturday =>1).count
    respond_with(@alumni_reservation)
    end
 
  end
  def create
  unless true
    valid=true
    @peaceprize_ceremony_count = AlumniReservation.where(:peaceprize_ceremony =>1).count
    @hybel_friday_count = AlumniReservation.where(:hybel_friday => 1).count
    @restaurant_count = AlumniReservation.where(:restaurant =>1).count
    @hybel_saturday_count = AlumniReservation.where(:hybel_saturday =>1).count
   @alumni_reservation = AlumniReservation.new(params[:alumni_reservation])
    
    if @peaceprize_ceremony_count >= 100 && @alumni_reservation.peaceprize_ceremony
      @alumni_reservation.errors.add :peaceprize_ceremony, "er dessverre full."	
      valid=false     

    end

    if @hybel_friday_count >= 100 && @alumni_reservation.hybel_friday
      @alumni_reservation.errors.add :hybel_friday, "er dessverre full."	
      valid=false      
	
    end

    if @hybel_saturday_count >= 100 && @alumni_reservation.hybel_saturday
      @alumni_reservation.errors.add :hybel_saturday, "er dessverre full."
      valid=false	
    end

    if @restaurant_count >= 100 && @alumni_reservation.restaurant
      @alumni_reservation.errors.add :restaurant, "er dessverre full."
      valid=false	
    end

 
    if valid && @alumni_reservation.save 
      flash[:notice] = 'Reservasjonen er registrert'
      redirect_to new_alumni_reservation_path(params[:tab])
    else
      render :action => 'new'
    end  
    #    respond_with(@alumni_reservation, :location => new_alumni_reservation_path(params[:tab]))
    end
  end
end
