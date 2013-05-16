class MailingListsController < ApplicationController

  def subscribe
    @entry = MailingList.new
    @entry.email = params[:email]
    if @entry.save
      Postoffice.subscription_mailing_list(@entry.email).deliver
      flash[:notice] = "#{params[:email} has subscribed to the mailing list."
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_to root_path
  end

  def unsubscribe
    @entry = MailingList.find_by_email(params[:email])
    unless @entry.nil?
      @entry.destroy
      flash[:notice] = "#{params[:email} was removed from the mailing list."
    else
      flash[:alert] = "Could not unsubscribe #{params[:email]}."
    end
    redirect_to root_path
  end
end
