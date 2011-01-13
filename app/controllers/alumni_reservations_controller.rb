class AlumniReservationsController < ApplicationController
  respond_to :html
  def new
    @alumni_reservation = AlumniReservation.new

    @peaceprice_ceremony_count=AlumniReservation.where(:peaceprize_ceremony =>1).count
    @hybel_friday_count= AlumniReservation.where(:hybel_friday =>1).count
    @restaurant_count=AlumniReservation.where(:restaurant =>1).count
    @hybel_saturday_count=AlumniReservation.where(:hybel_saturday =>1).count
    respond_with(@alumni_reservation)
 
  end
  def create
    valid=true
#    @peaceprice_ceremony_count=100
#    @hybel_friday_count=100
#    @restaurant_count=AlumniReservation.where(:restaurant =>1).count
#    @hybel_saturday_count=AlumniReservation.where(:hybel_saturday =>1).count
    @alumni_reservation = AlumniReservation.new(params[:alumni_reservation])

    @peaceprice_ceremony_count=AlumniReservation.where(:peaceprize_ceremony =>1).count
    @hybel_friday_count= AlumniReservation.where(:hybel_friday =>1).count
    @restaurant_count=AlumniReservation.where(:restaurant =>1).count
    @hybel_saturday_count=AlumniReservation.where(:hybel_saturday =>1).count
 
#    
#    if @peaceprice_ceremony_count >= 100 && params[:alumni_reservation][:peaceprize_ceremony]
#      @alumni_reservation.errors.add :peaceprize_ceremony, "The peaceprice ceremony is unfortunate fully booked."	
#      valid=false     
#
#    end
#
#    if @hybel_friday_count >= 100 && params[:alumni_reservation][:hybel_friday]
#      @alumni_reservation.errors.add :peaceprize_ceremony, "The hybel on friday is unfortunate fully booked."	
#      valid=false      
#	
#    end
#
#    if @hybel_saturday_count >= 100 && params[:alumni_reservation][:hybel_saturday]
#      @alumni_reservation.errors.add :peaceprize_ceremony, "The hybel on saturday is unfortunate fully booked."
#      valid=false	
#    end
#
#    if @restaurant_count >= 100 && params[:alumni_reservation][:restaurant_count]
#      @alumni_reservation.errors.add :peaceprize_ceremony, "The restaurant is unfortunate fully booked."
#      valid=false	
#    end

 
    if @alumni_reservation.save && valid
      flash[:notice] = 'Reservasjonen er registrert'
      redirect_to new_alumni_reservation_path(params[:tab])
    else
      render :action => 'new'
    end  
    #    respond_with(@alumni_reservation, :location => new_alumni_reservation_path(params[:tab]))
  end
end
