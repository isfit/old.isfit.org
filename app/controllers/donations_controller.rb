class DonationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def donate
    @donation = Donation.new
  end

  def thank_you

  end

  def create
    Donation.create!(:status => params[:payment_status], 
                     :transaction_number => params[:txn_id], 
                     :amount => params[:payment_gross],
                     :name => "#{params[:first_name]} #{params[:last_name]}",
                     :email => params[:receiver_email])
    render :nothing => true
  end
end
