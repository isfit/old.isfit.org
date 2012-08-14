class ParticipantsController < ApplicationController

  def index
    #Simple redirection
    redirect_to :tab=>params[:tab], :action => "new"
  end

  def new
    @participant = Participant.new
    @countries = Country.find(:all, :order=>"name")
    @workshops = Workshop.all
  end


  def create
    @countries = Country.find(:all, :order=>"name")
    @workshops = Workshop.all
    @participant = Participant.new(params[:participant])
    @participant.registered_time = DateTime.now


    # Do an error - check on birthday (not allow 30. feb etc)
    begin
      selected_day = params[:participant]['birthdate(1i)'].to_i
      selected_month = params[:participant]['birthdate(2i)'].to_i
      selected_year = params[:participant]['birthdate(3i)'].to_i
      Date.new(selected_day, selected_month, selected_year)
    rescue ArgumentError
      @participant.errors.add(:birthdate, 'is an invalid date')
      # Clear the birthdate, so it doesn't show the rolled-over date in the view.
      @participant.birthdate = nil
    end


    if @participant.valid? && verify_recaptcha(:model=>@participant, :message=>"Recaptcha verification failed") &&  @participant.save
      Postoffice.registered(@participant.first_name + " " + @participant.last_name, @participant.email).deliver
      flash[:notice] = "Your application was sent successfully. An email has been sent to #{@participant.email}"
      redirect_to new_participant_path
    else
      if !verify_recaptcha(:model=>@participant, :message=>"Recaptcha verification failed")
        flash[:alert] = "Wrong Recaptcha"
      end
      render :action=>"new"
    end
  end
end
