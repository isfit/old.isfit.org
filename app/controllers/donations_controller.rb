class DonationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def donate
    @donation = Donation.new
    #redirect_to page_path(60)
  end

  def thank_you
    if params[:payment_status] == "Completed"

    else
      redirect_to page_path(60)
    end
  end

  def create
    if params[:payment_status] == "Completed"
      Donation.create!(:status => params[:payment_status], 
                       :transaction_number => params[:txn_id], 
                       :amount => params[:payment_gross],
                       :name => "#{params[:first_name]} #{params[:last_name]}",
                       :email => params[:payer_email])
      Postoffice.donation("#{params[:first_name]} #{params[:last_name]}", params[:payer_email]).deliver
    end
    render :nothing => true
  end
end
