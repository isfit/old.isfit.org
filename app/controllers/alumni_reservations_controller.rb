class AlumniReservationsController < ApplicationController
  respond_to :html
  def new
    @alumni_reservation = AlumniReservation.new
    respond_with(@alumni_reservation)
  end

  def create
    @alumni_reservation = AlumniReservation.new(params[:alumni_reservation])

    if @alumni_reservation.save 
      flash[:notice] = 'Reservasjonen er registrert'
      redirect_to new_alumni_reservation_path(params[:tab])
    else
      render :action => 'new'
    end  
    #    respond_with(@alumni_reservation, :location => new_alumni_reservation_path(params[:tab]))
  end
end
