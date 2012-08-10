class DialogueParticipantsController < ApplicationController
  def index
  	redirect_to :action => "new"
  end

  def new
  	@countries = Country.find(:all, :order=>"name")
    @dialogue_participant = DialogueParticipant.new
  end

  def create
  	@countries = Country.find(:all, :order=>"name")
		@dialogue_participant = DialogueParticipant.new(params[:dialogue_participant])
		@dialogue_participant.registered_time = DateTime.now

    begin
      selected_day = params[:dialogue_participant]['birthdate(1i)'].to_i
      selected_month = params[:dialogue_participant]['birthdate(2i)'].to_i
      selected_year = params[:dialogue_participant]['birthdate(3i)'].to_i
      Date.new(selected_day, selected_month, selected_year)
    rescue ArgumentError
      @dialogue_participant.errors.add(:birthdate, 'is an invalid date')
      # Clear the birthdate, so it doesn't show the rolled-over date in the view.
      @dialogue_participant.birthdate = nil
    end
    
    if @dialogue_participant.valid? && verify_recaptcha(:model=>@dialogue_participant, :message=>"Recaptcha verification failed") && @dialogue_participant.save
			Postoffice.registered(@dialogue_participant.first_name + " " + @dialogue_participant.last_name, @dialogue_participant.email).deliver
			flash[:notice] = "Your application was sent successfully. You should receive an email as a confirmation to #{@dialogue_participant.email}."
      redirect_to new_dialogue_participant_path
		else
      verify_recaptcha(:model=>@dialogue_participant, :message=>"Recaptcha verification failed")
      render :action => "new"
      flash[:notice] = nil
		end
  end
end
