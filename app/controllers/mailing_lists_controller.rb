class MailingListsController < ApplicationController
  def index
  end

  def subscription
    if params[:commit].eql? 'Subscribe'
      subscribe
    elsif params[:commit].eql? 'Unsubscribe'
      unsubscribe
    end
  end

  def subscribe
    mail = params[:mailing_list][:email]

    @entry = MailingList.new
    @entry.email = mail
    if @entry.save
      Postoffice.subscription_mailing_list(@entry.email).deliver
      flash[:notice] = "#{mail} has subscribed to the mailing list."
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_to root_path, flash: { notice: flash[:notice], alert: flash[:alert] }
  end

  def unsubscribe
    mail = params[:mailing_list][:email]

    @entry = MailingList.find_by_email(mail)
    unless @entry.nil?
      @entry.destroy
      flash[:notice] = "#{mail} was removed from the mailing list."
    else
      flash[:alert] = "Could not unsubscribe #{mail}."
    end
    redirect_to root_path, flash: { notice: flash[:notice], alert: flash[:alert] }
  end
end
