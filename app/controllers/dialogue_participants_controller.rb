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
    begin
      @dialogue_participant = DialogueParticipant.new(params[:dialogue_participant])

      # Catch the exception from AR::Base
    rescue ActiveRecord::MultiparameterAssignmentErrors => ex
      # Iterarate over the exceptions and remove the invalid field components from the input
      ex.errors.each { |err| params[:dialogue_participant].delete_if { |key, value| key =~ /^#{err.attribute}/ } }
      # Recreate the Model with the bad input fields removed

      @dialogue_participant = Participant.new(params[:dialogue_participant])
    end
    @dialogue_participant.registered_time = DateTime.now
    if @dialogue_participant.valid? && verify_recaptcha(:model=>@dialogue_participant, :message=>"Recaptcha verification failed") && @dialogue_participant.save
      Postoffice.registered(@dialogue_participant.first_name + " " + @dialogue_participant.last_name, @dialogue_participant.email).deliver
      flash[:notice] = "Your application was sent successfully. You should receive an email as a confirmation at the email you provided"
    else
      verify_recaptcha(:model=>@dialogue_participant, :message=>"Recaptcha verification failed")
      flash[:notice] = nil
    end
    render tab: params[:tab], action: "new"

  end
end
