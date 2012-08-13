class DonationsController < ApplicationController
  before_filter :get_donation, :only => [:checkout, :paypal, :thank_you]

  def new
    @payment = Donation.new
  end
  
  def donate
  end

  def thank_you
  end
  
  def create
    @donation = Donation.new params[:donation]
    
    if @donation.save
      ## Paypal Checkout page
      redirect_to billing_path
    else
      @payment = Donation.new
      render :action => :new
    end
  end

  # ASSUMPTION
  # order is valid i.e. amount is entered
  def checkout
    response = @donation.setup_purchase(:return_url => confirm_paypal_url(@donation), :cancel_return_url => root_url)
    redirect_to @donation.redirect_url_for(response.token)
  end

  ## CALL BACK
  def paypal
    @donation = @donation.purchase(:token => params[:token], :payer_id => params[:PayerID], :ip => request.remote_ip)
    @donation.save
    redirect_to billing_thank_you_url(@order)
  end

  private
  def get_donation
    @donation = Donation.find_by_id(params[:id])
    @donation && @donation.valid? || invalid_url
  end
end
